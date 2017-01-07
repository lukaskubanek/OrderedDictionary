public struct OrderedDictionary<Key: Hashable, Value>: MutableCollection, BidirectionalCollection {

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
    ///   Each key in elements must be unique.
    public init(elements: [Element]) {
        for (key, value) in elements {
            self[key] = value
        }
    }
    
    // ======================================================= //
    // MARK: - Ordered Keys & Values
    // ======================================================= //
    
    /// A collection containing just the keys of the ordered dictionary in the correct order.
    public var orderedKeys: LazyMapBidirectionalCollection<OrderedDictionary<Key, Value>, Key> {
        return self.lazy.map { $0.key }
    }
    
    /// A collection containing just the values of the ordered dictionary in the correct order.
    public var orderedValues: LazyMapBidirectionalCollection<OrderedDictionary<Key, Value>, Value> {
        return self.lazy.map { $0.value }
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
    ///   otherwise, `nil`.
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set(newValue) {
            if let newValue = newValue {
                updateValue(newValue, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    /// Returns a Boolean value indicating whether the ordered dictionary contains
    /// the given key.
    ///
    /// - Parameter key: The key to be looked up.
    /// - Returns: `true` if the ordered dictionary contains the given key; otherwise, `false`.
    public func containsKey(_ key: Key) -> Bool {
        return _orderedKeys.contains(key)
    }
    
    /// Returns the value associated with the given key if the key is found in the ordered
    /// dictionary, or `nil` if the key is not found.
    ///
    /// - Parameter key: The key to find in the ordered dictionary.
    /// - Returns: The value associated with `key` if `key` is in the ordered dictionary;
    ///   otherwise, `nil`.
    public func value(forKey key: Key) -> Value? {
        return _keysToValues[key]
    }
    
    /// Updates the value stored in the ordered dictionary for the given key, or appends
    /// a new key-value pair if the key does not exist.
    ///
    /// - Parameter value: The new value to add to the ordered dictionary.
    /// - Parameter key: The key to associate with `value`. If `key` already exists in the 
    ///   ordered dictionary, `value` replaces the existing associated value. If `key` is not
    ///   already a key of the ordered dictionary, the `(key, value)` pair is appended at the
    ///   end of the ordered dictionary.
    @discardableResult
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        if _orderedKeys.contains(key) {
            let currentValue = _unsafeValue(forKey: key)
            
            _keysToValues[key] = value
            
            return currentValue
        } else {
            _orderedKeys.append(key)
            _keysToValues[key] = value
            
            return nil
        }
    }
    
    /// Removes the given key and its associated value from the ordered dictionary.
    ///
    /// If the key is found in the ordered dictionary, this method returns the key's associated
    /// value. On removal, the indices of the ordered dictionary are invalidated. If the key is 
    /// not found in the ordered dictionary, this method returns `nil`.
    ///
    /// - Parameter key: The key to remove along with its associated value.
    /// - Returns: The value that was removed, or `nil` if the key was not present in the 
    ///   ordered dictionary.
    @discardableResult
    public mutating func removeValue(forKey key: Key) -> Value? {
        if let index = _orderedKeys.index(of: key) {
            let currentValue = self[index].value
            
            _orderedKeys.remove(at: index)
            _keysToValues[key] = nil
            
            return currentValue
        } else {
            return nil
        }
    }
    
    /// Removes all key-value pairs from the ordered dictionary and invalidates all indices.
    ///
    /// - Parameter keepCapacity: Whether the ordered dictionary should keep its underlying 
    ///   storage. If you pass `true`, the operation preserves the storage capacity that the
    ///   collection has, otherwise the underlying storage is released. The default is `false`.
    public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
        _orderedKeys.removeAll(keepingCapacity: keepCapacity)
        _keysToValues.removeAll(keepingCapacity: keepCapacity)
    }
    
    private func _unsafeValue(forKey key: Key) -> Value {
        if let value = _keysToValues[key] {
            return value
        } else {
            fatalError("Inconsistency error occured in OrderedDictionary")
        }
    }
    
    // ======================================================= //
    // MARK: - Index-based Access
    // ======================================================= //
    
    /// Accesses the key-value pair at the specified position for reading and writing.
    ///
    /// The specified position has to be a valid index inside of the ordered dictionary.
    /// When reading the index-based subscript returns the key-value pair corresponding
    /// to the index.
    ///
    /// When you assign a key-value pair for an index, the given key has to either be located
    /// in the existing key-value pair at that index or not present in the ordered dictionary
    /// at all. The existing key-value pair is then overwritten with the new one. If the given
    /// key is present at another index of the ordered dictionary a runtime error is triggered.
    ///
    /// - Parameter position: The position of the key-value pair to access. `position` must be
    ///   a valid index of the ordered dictionary and not equal to `endIndex`.
    /// - Returns: A tuple containing the key-value pair corresponding to `position`.
    public subscript(position: Index) -> Element {
        get {
            precondition(indices.contains(position), "OrderedDictionary index is out of range")
            
            let key = _orderedKeys[position]
            let value = _unsafeValue(forKey: key)
            
            return (key, value)
        }
        set(newElement) {
            updateElement(newElement, atIndex: position)
        }
    }
    
    /// Returns the index for the given key.
    ///
    /// - Parameter key: The key to find in the ordered dictionary.
    /// - Returns: The index for `key` and its associated value if `key` is in the ordered dictionary;
    ///   otherwise, `nil`.
    public func index(forKey key: Key) -> Index? {
        return _orderedKeys.index(of: key)
    }
    
    /// Returns the key-value pair at the specified index, or `nil` if there is no key-value pair
    /// at that index.
    ///
    /// - Parameter index: The index of the key-value pair to be looked up. `index` does not have to
    ///   be a valid index.
    /// - Returns: A tuple containing the key-value pair corresponding to `index` if the index is valid;
    ///   otherwise, `nil`.
    public func elementAt(_ index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// Inserts a new key-value pair at the specified position.
    ///
    /// ...
    @discardableResult
    public mutating func insert(_ newElement: Element, at index: Index) -> Value? {
        precondition(index >= startIndex, "Negative OrderedDictionary index is out of range")
        precondition(index <= endIndex, "OrderedDictionary index is out of range")
        
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
        precondition(indices.contains(index), "OrderedDictionary index is out of range")
        
        let currentElement = self[index]
        
        let (newKey, newValue) = element
        
        _orderedKeys[index] = newKey
        _keysToValues[newKey] = newValue
        
        return currentElement
    }
    
    /// Removes and returns the key-value pair at the specified position if there is any key-value pair,
    /// or `nil` if there is none.
    ///
    /// - Parameter index: The position of the key-value pair to remove.
    /// - Returns: The element at the specified index, or `nil` if the position is not taken.
    @discardableResult
    public mutating func remove(at index: Index) -> Element? {
        guard let element = elementAt(index) else { return nil }
        
        _orderedKeys.remove(at: index)
        _keysToValues.removeValue(forKey: element.key)
        
        return element
    }
    
    // ======================================================= //
    // MARK: - Sorting
    // ======================================================= //
    
    /// Sorts the ordered dictionary in place, using the given predicate as the comparison between elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements.
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns `true` if its first argument should be 
    ///   ordered before its second argument; otherwise, `false`.
    ///
    /// - SeeAlso: MutableCollection.sort(by:), sorted(by:)
    public mutating func sort(by areInIncreasingOrder: (Element, Element) -> Bool) {
        _orderedKeys = _sortedElements(by: areInIncreasingOrder).map { $0.key }
    }
    
    /// Returns a new ordered dictionary, sorted using the given predicate as the comparison between elements.
    ///
    /// The predicate must be a *strict weak ordering* over the elements.
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns `true` if its first argument should be
    ///   ordered before its second argument; otherwise, `false`.
    /// - Returns: A new ordered dictionary sorted according to the predicate.
    ///
    /// - SeeAlso: MutableCollection.sorted(by:), sort(by:)
    /// - MutatingVariant: sort
    public func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> OrderedDictionary<Key, Value> {
        return OrderedDictionary(elements: _sortedElements(by: areInIncreasingOrder))
    }
    
    private func _sortedElements(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
        return sorted(by: areInIncreasingOrder)
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
    
    public var indices: Indices {
        return _orderedKeys.indices
    }

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
        return lhs._orderedKeys == rhs._orderedKeys
            && lhs._keysToValues == rhs._keysToValues
    }
    
}
