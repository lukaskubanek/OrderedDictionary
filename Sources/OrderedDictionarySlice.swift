public struct OrderedDictionarySlice<Key: Hashable, Value>: BidirectionalCollection {
    
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
    // MARK: - BidirectionalCollection Conformance
    // ======================================================= //
    
    public subscript(position: Index) -> Element {
        return _slice[position]
    }
    
    public var indices: Indices {
        return _slice.base.indices
    }

    public var startIndex: Index {
        return _slice.base.startIndex
    }
    
    public var endIndex: Index {
        return _slice.base.endIndex
    }
    
    public func index(after i: Index) -> Index {
        return _slice.base.index(after: i)
    }

    public func index(before i: Index) -> Index {
        return _slice.base.index(before: i)
    }
    
    // ======================================================= //
    // MARK: - Internal Storage
    // ======================================================= //
    
    private var _slice: Slice<OrderedDictionary<Key, Value>>
    
}
