//
//  OrderedDictionary.swift
//  OrderedDictionary
//
//  Created by Lukas Kubanek on 29/08/15.
//  Copyright © 2015 Lukas Kubanek. All rights reserved.
//

public struct OrderedDictionary<Key: Hashable, Value>: MutableCollectionType {
    
    // ======================================================= //
    // MARK: - Type Aliases
    // ======================================================= //
    
    public typealias Element = (Key, Value)
    
    public typealias Index = Int
    
    // ======================================================= //
    // MARK: - Initialization
    // ======================================================= //
    
    public init() {}
    
    public init(elements: [Element]) {
        for (key, value) in elements {
            self[key] = value
        }
    }
    
    // ======================================================= //
    // MARK: - Accessing Keys & Values
    // ======================================================= //
    
    public var orderedKeys: [Key] {
        return _orderedKeys
    }
    
    public var orderedValues: [Value] {
        return _orderedKeys.flatMap { _keysToValues[$0] }
    }
    
    // ======================================================= //
    // MARK: - Managing Content Using Keys
    // ======================================================= //
    
    public subscript(key: Key) -> Value? {
        get {
            return valueForKey(key)
        }
        set(newValue) {
            if let newValue = newValue {
                updateValue(newValue, forKey: key)
            } else {
                removeValueForKey(key)
            }
        }
    }
    
    public func containsKey(key: Key) -> Bool {
        return _orderedKeys.contains(key)
    }
    
    public func valueForKey(key: Key) -> Value? {
        return _keysToValues[key]
    }
    
    public mutating func updateValue(value: Value, forKey key: Key) -> Value? {
        if _orderedKeys.contains(key) {
            guard let currentValue = _keysToValues[key] else {
                fatalError("Inconsistency error occured in OrderedDictionary")
            }
            
            _keysToValues[key] = value
            
            return currentValue
        } else {
            _orderedKeys.append(key)
            _keysToValues[key] = value
            
            return nil
        }
    }
    
    public mutating func removeValueForKey(key: Key) -> Value? {
        if let index = _orderedKeys.indexOf(key) {
            guard let currentValue = _keysToValues[key] else {
                fatalError("Inconsistency error occured in OrderedDictionary")
            }
            
            _orderedKeys.removeAtIndex(index)
            _keysToValues[key] = nil
            
            return currentValue
        } else {
            return nil
        }
    }
    
    public mutating func removeAll(keepCapacity keepCapacity: Bool = true) {
        _orderedKeys.removeAll(keepCapacity: keepCapacity)
        _keysToValues.removeAll(keepCapacity: keepCapacity)
    }
    
    // ======================================================= //
    // MARK: - Managing Content Using Indexes
    // ======================================================= //
    
    public subscript(index: Index) -> Element {
        get {
            guard let element = elementAtIndex(index) else {
                fatalError("OrderedDictionary index out of range")
            }
            
            return element
        }
        set(newValue) {
            updateElement(newValue, atIndex: index)
        }
    }
    
    public func indexForKey(key: Key) -> Index? {
        return _orderedKeys.indexOf(key)
    }
    
    public func elementAtIndex(index: Index) -> Element? {
        guard _orderedKeys.indices.contains(index) else { return nil }
        
        let key = _orderedKeys[index]
        
        guard let value = self._keysToValues[key] else {
            fatalError("Inconsistency error occured in OrderedDictionary")
        }
        
        return (key, value)
    }
    
    public mutating func insertElementWithKey(key: Key, value: Value, atIndex index: Index) -> Value? {
        return insertElement((key, value), atIndex: index)
    }
    
    public mutating func insertElement(newElement: Element, atIndex index: Index) -> Value? {
        guard index >= 0 else {
            fatalError("Negative OrderedDictionary index is out of range")
        }
        
        guard index <= count else {
            fatalError("OrderedDictionary index out of range")
        }
        
        let (key, value) = newElement
        
        let adjustedIndex: Int
        let currentValue: Value?
        
        if let currentIndex = _orderedKeys.indexOf(key) {
            currentValue = _keysToValues[key]
            adjustedIndex = (currentIndex < index - 1) ? index - 1 : index
            
            _orderedKeys.removeAtIndex(currentIndex)
            _keysToValues[key] = nil
        } else {
            currentValue = nil
            adjustedIndex = index
        }
        
        _orderedKeys.insert(key, atIndex: adjustedIndex)
        _keysToValues[key] = value
        
        return currentValue
    }
    
    public mutating func updateElement(element: Element, atIndex index: Index) -> Element? {
        guard let currentElement = elementAtIndex(index) else {
            fatalError("OrderedDictionary index out of range")
        }
        
        let (newKey, newValue) = element
        
        _orderedKeys[index] = newKey
        _keysToValues[newKey] = newValue
        
        return currentElement
    }
    
    public mutating func removeAtIndex(index: Index) -> Element? {
        if let element = elementAtIndex(index) {
            _orderedKeys.removeAtIndex(index)
            _keysToValues.removeValueForKey(element.0)
            
            return element
        } else {
            return nil
        }
    }
    
    // ======================================================= //
    // MARK: - CollectionType Conformance
    // ======================================================= //
    
    public var startIndex: Index {
        return _orderedKeys.startIndex
    }
    
    public var endIndex: Index {
        return _orderedKeys.endIndex
    }
    
    // ======================================================= //
    // MARK: - Internal Backing Store
    // ======================================================= //
    
    /// The backing store for the ordered keys.
    private var _orderedKeys = [Key]()
    
    /// The backing store for the mapping of keys to values.
    private var _keysToValues = [Key: Value]()
    
}

// ======================================================= //
// MARK: - Initializations from Literals
// ======================================================= //

extension OrderedDictionary: ArrayLiteralConvertible {
    
    public init(arrayLiteral elements: Element...) {
        self.init(elements: elements)
    }
    
}

extension OrderedDictionary: DictionaryLiteralConvertible {
    
    public init(dictionaryLiteral elements: Element...) {
        self.init(elements: elements)
    }
    
}

// ======================================================= //
// MARK: - Description
// ======================================================= //

extension OrderedDictionary: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return constructDescription(debug: false)
    }
    
    public var debugDescription: String {
        return constructDescription(debug: true)
    }
    
    private func constructDescription(debug debug: Bool) -> String {
        // The implementation of the description is inspired by zwaldowski's implementation of the ordered dictionary.
        // See http://bit.ly/1VL4JUR
        
        if isEmpty { return "[:]" }
        
        func descriptionForItem(item: Any) -> String {
            var description = ""
            
            if debug {
                debugPrint(item, separator: "", terminator: "", toStream: &description)
            } else {
                print(item, separator: "", terminator: "", toStream: &description)
            }
            
            return description
        }
        
        let bodyComponents = map({ (key: Key, value: Value) -> String in
            return descriptionForItem(key) + ": " + descriptionForItem(value)
        })
        
        let body = bodyComponents.joinWithSeparator(", ")
        
        return "[\(body)]"
    }
    
}

public func == <Key: Equatable, Value: Equatable>(lhs: OrderedDictionary<Key, Value>, rhs: OrderedDictionary<Key, Value>) -> Bool {
    return lhs._orderedKeys == rhs._orderedKeys && lhs._keysToValues == rhs._keysToValues
}
