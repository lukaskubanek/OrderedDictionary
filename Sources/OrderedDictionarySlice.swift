/// A view into an ordered dictionary.
///
/// - SeeAlso: OrderedDictionary
/// - SeeAlso: BidirectionalSlice
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
    
    /// The type of the indices collection of the slice.
    public typealias Indices = BidirectionalSlice<Base>.Indices
    
    /// The type of the contiguous subrange of the ordered dictionary's slice.
    public typealias SubSequence = OrderedDictionarySlice<Key, Value>
    
    // ======================================================= //
    // MARK: - Initialization
    // ======================================================= //
    
    /// Initializes the view into the given ordered dictionary that allows access to elements within 
    /// the given range.
    ///
    /// - Parameter base: The ordered dictionary to create a view into.
    /// - Parameter bounds: The range of indices to allow access to in the new slice.
    internal init(base: Base, bounds: Range<Index>) {
        self._slice = BidirectionalSlice(base: base, bounds: bounds)
    }
    
    // ======================================================= //
    // MARK: - BidirectionalCollection Conformance
    // ======================================================= //
    
    /// Accesses the key-value pair at the specified position.
    public subscript(position: Index) -> Element {
        return _slice[position]
    }
    
    /// The indices that are valid for subscripting the ordered dictionary slice.
    public var indices: Indices {
        return _slice.indices
    }

    /// The position of the first key-value pair in the ordered dictionary slice.
    public var startIndex: Index {
        return _slice.startIndex
    }
    
    /// The position which is one greater than the position of the last valid key-value pair in the
    /// ordered dictionary slice.
    public var endIndex: Index {
        return _slice.endIndex
    }
    
    /// Returns the position immediately after the given index.
    public func index(after i: Index) -> Index {
        return _slice.index(after: i)
    }

    /// Returns the position immediately before the given index.
    public func index(before i: Index) -> Index {
        return _slice.index(before: i)
    }
    
    // ======================================================= //
    // MARK: - Internal Storage
    // ======================================================= //
    
    /// The underlying slice value.
    private var _slice: BidirectionalSlice<Base>
    
}
