public struct OrderedDictionary<Key: Hashable, Value>: MutableCollection, RandomAccessCollection {
    
    // ======================================================= //
    // MARK: - Type Aliases
    // ======================================================= //
    
    /// The type of the key-value pair stored in the ordered dictionary.
    public typealias Element = (key: Key, value: Value)
    
    /// The type of the index.
    public typealias Index = Int
    
    /// The type of the indices collection.
    public typealias Indices = CountableRange<Int>
    
    /// The type of the contiguous subrange of the ordered dictionary's elements.
    public typealias SubSequence = OrderedDictionarySlice<Key, Value>
    
    // ======================================================= //
    // MARK: - Initialization
    // ======================================================= //
    
    /// Creates an empty ordered dictionary.
    public init() {}
    
    /// Creates an ordered dictionary with an array of key-value pairs.
    ///
    /// - Parameter elements: The key-value pairs that will make up the new ordered dictionary. 
    /// Each key in elements must be unique.
    public init(elements: [Element]) {
        for (key, value) in elements {
            self[key] = value
        }
    }
    
    // ======================================================= //
    // MARK: - Ordered Elements, Keys & Values
    // ======================================================= //
    
    /// A copied array of the ordered elements.
    public var orderedElements: [Element] {
        return Array(self)
    }
    
    /// A copied array of the ordered keys.
    public var orderedKeys: [Key] {
        return _orderedKeys
    }
    
    /// A copied array of the ordered values.
    public var orderedValues: [Value] {
        return _orderedKeys.flatMap { _keysToValues[$0] }
    }
    
    // ======================================================= //
    // MARK: - Key-based Access
    // ======================================================= //
    
    /// Accesses the value associated with the given key for reading and writing.
    ///
    /// This key-based subscript returns the value for the given key if the key
    /// is found in the ordered dictionary, or `nil` if the key is not found.
    ///
    /// When you assign a value for a key and that key already exists, the ordered
    /// dictionary overwrites the existing value and preservers the index of the
    /// key-value pair. If the ordered dictionary does not contain the key, a new
    /// key-value pair is appended to the end of the ordered dictionary.
    ///
    /// If you assign `nil` as the value for the given key, the ordered dictionary
    /// removes that key and its associated value if it exists.
    ///
    /// - Parameter key: The key to find in the ordered dictionary.
    /// - Returns: The value associated with `key` if `key` is in the ordered dictionary; 
    /// otherwise, `nil`.
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set(newValue) {
            if let newValue = newValue {
                updateValue(newValue, forKey: key)
            } else {
                removeValueForKey(key)
            }
        }
    }
    
    /// Returns a Boolean value indicating whether the ordered dictionary contains
    /// the given key.
    ///
    /// - Parameter key: The key to be looked up.
    /// - Returns: `true` if the ordered dictionary contains the given key; otherwise, `false`.
    public func contains(key: Key) -> Bool {
        return _orderedKeys.contains(key)
    }
    
    /// Returns the value associated with the given key if the key is found in the ordered
    /// dictionary, or `nil` if the key is not found.
    ///
    /// - Parameter key: The key to find in the ordered dictionary.
    /// - Returns: The value associated with `key` if `key` is in the ordered dictionary;
    /// otherwise, `nil`.
    public func value(forKey key: Key) -> Value? {
        return _keysToValues[key]
    }
    
    @discardableResult
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
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
    
    @discardableResult
    public mutating func removeValueForKey(_ key: Key) -> Value? {
        if let index = _orderedKeys.index(of: key) {
            guard let currentValue = _keysToValues[key] else {
                fatalError("Inconsistency error occured in OrderedDictionary")
            }
            
            _orderedKeys.remove(at: index)
            _keysToValues[key] = nil
            
            return currentValue
        } else {
            return nil
        }
    }
    
    public mutating func removeAll(keepingCapacity: Bool = true) {
        _orderedKeys.removeAll(keepingCapacity: keepingCapacity)
        _keysToValues.removeAll(keepingCapacity: keepingCapacity)
    }
    
    // ======================================================= //
    // MARK: - Position-based Access
    // ======================================================= //
    
    public subscript(position: Index) -> Element {
        get {
            guard let element = elementAtIndex(position) else {
                fatalError("OrderedDictionary index out of range")
            }
            
            return element
        }
        set(newValue) {
            updateElement(newValue, atIndex: position)
        }
    }
    
    public func indexForKey(_ key: Key) -> Index? {
        return _orderedKeys.index(of: key)
    }
    
    public func elementAtIndex(_ index: Index) -> Element? {
        guard _orderedKeys.indices.contains(index) else { return nil }
        
        let key = _orderedKeys[index]
        
        guard let value = self._keysToValues[key] else {
            fatalError("Inconsistency error occured in OrderedDictionary")
        }
        
        return (key, value)
    }
    
    @discardableResult
    public mutating func insertElementWithKey(_ key: Key, value: Value, atIndex index: Index) -> Value? {
        return insertElement((key, value), atIndex: index)
    }
    
    @discardableResult
    public mutating func insertElement(_ newElement: Element, atIndex index: Index) -> Value? {
        guard index >= 0 else {
            fatalError("Negative OrderedDictionary index is out of range")
        }
        
        guard index <= count else {
            fatalError("OrderedDictionary index out of range")
        }
        
        let (key, value) = newElement
        
        let adjustedIndex: Int
        let currentValue: Value?
        
        if let currentIndex = _orderedKeys.index(of: key) {
            currentValue = _keysToValues[key]
            adjustedIndex = (currentIndex < index - 1) ? index - 1 : index
            
            _orderedKeys.remove(at: currentIndex)
            _keysToValues[key] = nil
        } else {
            currentValue = nil
            adjustedIndex = index
        }
        
        _orderedKeys.insert(key, at: adjustedIndex)
        _keysToValues[key] = value
        
        return currentValue
    }
    
    @discardableResult
    public mutating func updateElement(_ element: Element, atIndex index: Index) -> Element? {
        guard let currentElement = elementAtIndex(index) else {
            fatalError("OrderedDictionary index out of range")
        }
        
        let (newKey, newValue) = element
        
        _orderedKeys[index] = newKey
        _keysToValues[newKey] = newValue
        
        return currentElement
    }
    
    @discardableResult
    public mutating func removeAtIndex(_ index: Index) -> Element? {
        if let element = elementAtIndex(index) {
            _orderedKeys.remove(at: index)
            _keysToValues.removeValue(forKey: element.0)
            
            return element
        } else {
            return nil
        }
    }
    
    // ======================================================= //
    // MARK: - Slices
    // ======================================================= //
    
    public subscript(bounds: Range<Index>) -> SubSequence {
        get {
            return OrderedDictionarySlice(base: self, bounds: bounds)
        }
        set(newSequence) {
            for (index, element) in newSequence.enumerated() {
                fatalError("set element \(element) for index \(index)")
            }
        }
    }
    
    // ======================================================= //
    // MARK: - Indices
    // ======================================================= //
    
    public var startIndex: Index {
        return _orderedKeys.startIndex
    }
    
    public var endIndex: Index {
        return _orderedKeys.endIndex
    }
    
    public func index(before i: Index) -> Index {
        return _orderedKeys.index(before: i)
    }
    
    public func index(after i: Index) -> Index {
        return _orderedKeys.index(after: i)
    }
    
    // ======================================================= //
    // MARK: - Internal Storage
    // ======================================================= //
    
    /// The backing storage for the ordered keys.
    fileprivate var _orderedKeys = [Key]()
    
    /// The backing storage for the mapping of keys to values.
    fileprivate var _keysToValues = [Key: Value]()
    
}

// ======================================================= //
// MARK: - Literals
// ======================================================= //

extension OrderedDictionary: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Element...) {
        self.init(elements: elements)
    }
    
}

/// Creates an ordered dictionary initialized with a dictionary literal.
extension OrderedDictionary: ExpressibleByDictionaryLiteral {
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self.init(elements: elements)
    }
    
}

// ======================================================= //
// MARK: - Description
// ======================================================= //

extension OrderedDictionary: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return constructDescription(false)
    }

    public var debugDescription: String {
        return constructDescription(true)
    }

    fileprivate func constructDescription(_ debug: Bool) -> String {
        // The implementation of the description is inspired by zwaldowski's implementation of the ordered dictionary.
        // See http://bit.ly/1VL4JUR

        if isEmpty { return "[:]" }

        func descriptionForItem(_ item: Any) -> String {
            var description = ""

            if debug {
                debugPrint(item, separator: "", terminator: "", to: &description)
            } else {
                print(item, separator: "", terminator: "", to: &description)
            }

            return description
        }

        let bodyComponents = map({ (key: Key, value: Value) -> String in
            return descriptionForItem(key) + ": " + descriptionForItem(value)
        })

        let body = bodyComponents.joined(separator: ", ")

        return "[\(body)]"
    }

}

// ======================================================= //
// MARK: - Equality
// ======================================================= //

extension OrderedDictionary /* : Equatable */ where Key: Equatable, Value: Equatable {
    
    public static func == (lhs: OrderedDictionary, rhs: OrderedDictionary) -> Bool {
        return lhs._orderedKeys == rhs._orderedKeys && lhs._keysToValues == rhs._keysToValues
    }
    
}
