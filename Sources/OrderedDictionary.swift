//
//  OrderedDictionary.swift
//  OrderedDictionary
//
//  Created by Lukas Kubanek on 29/08/15.
//  Copyright © 2015 Lukas Kubanek. All rights reserved.
//

/// The `OrderedDictionary` is a collection which combines the features of `Dictionary` and `Array`.
/// It maps keys to values and additionally sorts the key-value pairs by zero-based integer index.
public struct OrderedDictionary<Key : Hashable, Value>: CollectionType, ArrayLiteralConvertible, CustomStringConvertible {
    
    // MARK: - Initialization
    
    public init() {
        self.orderedKeys = []
        self.keysToValues = [:]
    }
    
    public init(arrayLiteral elements: Element...) {
        self.init()
        
        for element in elements {
            self[element.0] = element.1
        }
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
    
    public mutating func updateValue(value: Value, forKey key: Key) -> Value? {
        if orderedKeys.contains(key) {
            guard let currentValue = keysToValues[key] else { fatalError("Inconsistency error occured in OrderedDictionary.") }
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
            orderedKeys.removeAtIndex(index)
            guard let currentValue = keysToValues[key] else { fatalError("Inconsistency error occured in OrderedDictionary.") }
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
            if let element = elementAtIndex(index) {
                return element
            } else {
                fatalError("Index out of bounds in OrderedDictionary.")
            }
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
        guard let value = self.keysToValues[key] else { fatalError("Inconsistency error occured in OrderedDictionary.") }
        
        return (key, value)
    }
    
    public mutating func updateElement(element: Element, atIndex index: Index) -> Element? {
        // TODO: Handle index out of range
        
        let currentElement = elementAtIndex(index)
        
        if currentElement != nil {
            keysToValues.removeValueForKey(element.0)
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
            guard let nextValue = self.keysToValues[nextKey] else { fatalError("Inconsistency error occured in OrderedDictionary.") }
            let element = (nextKey, nextValue)
            
            nextIndex++
            
            return element
        }
    }
    
    public var startIndex: Index { return orderedKeys.startIndex }
    
    public var endIndex: Index { return orderedKeys.endIndex }
    
}
