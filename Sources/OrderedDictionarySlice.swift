public struct OrderedDictionarySlice<Key: Hashable, Value>: RandomAccessCollection {
    
    // ======================================================= //
    // MARK: - Type Aliases
    // ======================================================= //
    
    /// The type of the base ordered dictionary.
    public typealias Base = OrderedDictionary<Key, Value>
    
    /// The type of the elements of the base ordered dictionary.
    public typealias Element = Base.Element
    
    /// The type of a single index of the base ordered dictionary.
    public typealias Index = Base.Index
    
    /// The type of the indices collection of the base ordered dictionary.
    public typealias Indices = Base.Indices
    
    // ======================================================= //
    // MARK: - Initialization
    // ======================================================= //
    
    internal init(base: Base, bounds: Range<Index>) {
        self._slice = Slice(base: base, bounds: bounds)
    }
    
    // ======================================================= //
    // MARK: - RandomAccessCollection Conformance
    // ======================================================= //
    
    public subscript(position: Index) -> Element {
        return _slice[position]
    }
    
    public var startIndex: Index {
        return _slice.startIndex
    }
    
    public var endIndex: Index {
        return _slice.endIndex
    }
    
    public func index(after i: Index) -> Index {
        return _slice.index(after: i)
    }
    
    // ======================================================= //
    // MARK: - Internal Storage
    // ======================================================= //
    
    private var _slice: Slice<OrderedDictionary<Key, Value>>
    
}
