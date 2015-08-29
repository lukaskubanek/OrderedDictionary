//
//  OrderedDictionary.swift
//  OrderedDictionary
//
//  Created by Lukas Kubanek on 29/08/15.
//  Copyright © 2015 Lukas Kubanek. All rights reserved.
//

public struct OrderedDictionary<Key : Hashable, Value>: CollectionType {
    
    // MARK: - Type Aliases
    
    public typealias Element = (Key, Value)
    public typealias Index = Int
    
    // MARK: - Initialization
    
    public init() {
        self.orderedKeys = []
        self.keysToValues = [:]
    }
    
    // MARK: - SequenceType Conformance

    public func generate() -> AnyGenerator<Element> {
        var nextIndex = 0
        let lastIndex = count
        
        return anyGenerator {
            guard nextIndex <= lastIndex else { return nil }
            
            let nextKey = self.orderedKeys[nextIndex]
            guard let nextValue = self.keysToValues[nextKey] else { fatalError("Inconsistency error occured in OrderedDictionary.") }
            let element = (nextKey, nextValue)
            
            nextIndex++
            
            return element
        }
    }
    
    // MARK: - Indexable Conformance
    
    public var startIndex: Index { return orderedKeys.startIndex }
    
    public var endIndex: Index { return orderedKeys.endIndex }
    
    public subscript(index: Index) -> Element {
        let key = orderedKeys[index]
        guard let value = self.keysToValues[key] else { fatalError("Inconsistency error occured in OrderedDictionary.") }
        
        return (key, value)
    }
    
    // MARK: - Backing Storage
    
    private var orderedKeys: [Key]
    private var keysToValues: [Key: Value]
    
}
