//
//  OrderedDictionary.swift
//  OrderedDictionary
//
//  Created by Lukas Kubanek on 29/08/15.
//  Copyright © 2015 Lukas Kubanek. All rights reserved.
//

public struct OrderedDictionary<Key : Hashable, Value>: CollectionType {
    
    // MARK: - Initialization
    
    public init() {
        self.orderedKeys = []
        self.keysToValues = [:]
    }
    
    // MARK: - Type Aliases
    
    public typealias Element = (Key, Value)
    public typealias Index = Int
    
    // MARK: - Managing Content
    
    public subscript(key: Key) -> Value? {
        get {
            return keysToValues[key]
        }
        set(newValue) {
            switch newValue {
            case nil:
                if let index = orderedKeys.indexOf(key) {
                    orderedKeys.removeAtIndex(index)
                }
                keysToValues[key] = nil
            case let newValue where orderedKeys.contains(key):
                keysToValues[key] = newValue
            default:
                orderedKeys.append(key)
                keysToValues[key] = newValue
            }
        }
    }
    
    public subscript(index: Index) -> Element {
        get {
            guard orderedKeys.indices.contains(index) else { fatalError("Index out of bounds in OrderedDictionary.") }
            
            let key = orderedKeys[index]
            guard let value = self.keysToValues[key] else { fatalError("Inconsistency error occured in OrderedDictionary.") }
            
            return (key, value)
        }
        set(newValue) {
            let newKey = newValue.0
            let newValue = newValue.1
            
            orderedKeys[index] = newKey
            keysToValues[newKey] = newValue
        }
    }
    
    // MARK: - Backing Storage
    
    private var orderedKeys: [Key]
    private var keysToValues: [Key: Value]
    
    // MARK: - SequenceType & Indexable Conformance

    public func generate() -> AnyGenerator<Element> {
        var nextIndex = 0
        let lastIndex = self.count
        
        return anyGenerator {
            guard nextIndex <= lastIndex else { return nil }
            
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
