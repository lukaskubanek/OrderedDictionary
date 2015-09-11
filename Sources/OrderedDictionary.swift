//
//  OrderedDictionary.swift
//  OrderedDictionary
//
//  Created by Lukas Kubanek on 29/08/15.
//  Copyright © 2015 Lukas Kubanek. All rights reserved.
//

public struct OrderedDictionary<Key: Hashable, Value>: CollectionType, ArrayLiteralConvertible, CustomStringConvertible {
    
    // MARK: - Initialization
    
    public init() {
        self.orderedKeys = []
        self.keysToValues = [:]
    }
    
    public init(elements: [Element]) {
        self.init()
        
        for element in elements {
            self[element.0] = element.1
        }
    }
    
    public init(arrayLiteral elements: Element...) {
        self.init(elements: elements)
    }
    
    // MARK: - Type Aliases
    
    public typealias Element = (Key, Value)
    public typealias Index = Int
    
    // MARK: - Managing Content Using Keys
    
    public subscript(key: Key) -> Value? {
        get {
            return keysToValues[key]
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
        return orderedKeys.contains(key)
    }
    
    public mutating func updateValue(value: Value, forKey key: Key) -> Value? {
        if orderedKeys.contains(key) {
            guard let currentValue = keysToValues[key] else {
                fatalError("Inconsistency error occured in OrderedDictionary")
            }
            
            keysToValues[key] = value
            
            return currentValue
        } else {
            orderedKeys.append(key)
            keysToValues[key] = value
            
            return nil
        }
    }
    
    public mutating func removeValueForKey(key: Key) -> Value? {
        if let index = orderedKeys.indexOf(key) {
            guard let currentValue = keysToValues[key] else {
                fatalError("Inconsistency error occured in OrderedDictionary")
            }
            
            orderedKeys.removeAtIndex(index)
            keysToValues[key] = nil
            
            return currentValue
        } else {
            return nil
        }
    }
    
    public mutating func removeAll(keepCapacity keepCapacity: Bool = true) {
        orderedKeys.removeAll(keepCapacity: keepCapacity)
        keysToValues.removeAll(keepCapacity: keepCapacity)
    }
    
    // MARK: - Managing Content Using Indexes
    
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
        return orderedKeys.indexOf(key)
    }
    
    public func elementAtIndex(index: Index) -> Element? {
        guard orderedKeys.indices.contains(index) else { return nil }
        
        let key = orderedKeys[index]
        
        guard let value = self.keysToValues[key] else {
            fatalError("Inconsistency error occured in OrderedDictionary")
        }
        
        return (key, value)
    }
    
    public mutating func insertElement(newElement: Element, atIndex index: Index) -> Value? {
        guard index >= 0 else {
            fatalError("Negative OrderedDictionary index is out of range")
        }
        
        guard index <= count else {
            fatalError("OrderedDictionary index out of range")
        }
        
        let (key, value) = (newElement.0, newElement.1)
        
        let adjustedIndex: Int
        let currentValue: Value?
        
        if let currentIndex = orderedKeys.indexOf(key) {
            currentValue = keysToValues[key]
            adjustedIndex = (currentIndex < index - 1) ? index - 1 : index
            
            orderedKeys.removeAtIndex(currentIndex)
            keysToValues[key] = nil
        } else {
            currentValue = nil
            adjustedIndex = index
        }
        
        orderedKeys.insert(key, atIndex: adjustedIndex)
        keysToValues[key] = value
        
        return currentValue
    }
    
    public mutating func updateElement(element: Element, atIndex index: Index) -> Element? {
        guard let currentElement = elementAtIndex(index) else {
            fatalError("OrderedDictionary index out of range")
        }
        
        let (newKey, newValue) = (element.0, element.1)
        
        orderedKeys[index] = newKey
        keysToValues[newKey] = newValue
        
        return currentElement
    }
    
    public mutating func removeAtIndex(index: Index) -> Element? {
        if let element = elementAtIndex(index) {
            orderedKeys.removeAtIndex(index)
            keysToValues.removeValueForKey(element.0)
            
            return element
        } else {
            return nil
        }
    }
    
    // MARK: - Description
    
    public var description: String {
        let content = map({ "\($0.0): \($0.1)" }).joinWithSeparator(", ")
        return "[\(content)]"
    }
    
    // MARK: - Backing Store
    
    private var orderedKeys: [Key]
    private var keysToValues: [Key: Value]
    
    // MARK: - SequenceType & Indexable Conformance

    public func generate() -> AnyGenerator<Element> {
        var nextIndex = 0
        let lastIndex = self.count
        
        return anyGenerator {
            guard nextIndex < lastIndex else { return nil }
            
            let nextKey = self.orderedKeys[nextIndex]
            
            guard let nextValue = self.keysToValues[nextKey] else {
                fatalError("Inconsistency error occured in OrderedDictionary")
            }
            
            let element = (nextKey, nextValue)
            
            nextIndex++
            
            return element
        }
    }
    
    public var startIndex: Index { return orderedKeys.startIndex }
    
    public var endIndex: Index { return orderedKeys.endIndex }
    
}

public func == <Key: Equatable, Value: Equatable>(lhs: OrderedDictionary<Key, Value>, rhs: OrderedDictionary<Key, Value>) -> Bool {
    return lhs.orderedKeys == rhs.orderedKeys && lhs.keysToValues == rhs.keysToValues
}
