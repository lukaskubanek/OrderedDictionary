extension OrderedDictionary {
    
    @available(*, unavailable, renamed:"value(forKey:)")
    public func valueForKey(_ key: Key) -> Value? { fatalError() }
    
    @available(*, unavailable, renamed:"removeValue(forKey:)")
    public mutating func removeValueForKey(_ key: Key) -> Value? { fatalError() }
    
    @available(*, unavailable, renamed:"removeAll(keepingCapacity:)")
    public mutating func removeAll(keepCapacity: Bool) -> Value? { fatalError() }
    
    @available(*, unavailable, renamed:"index(forKey:)")
    public func indexForKey(_ key: Key) -> Index? { fatalError() }
    
    @available(*, unavailable, renamed:"elementAt(_:)")
    public func elementAtIndex(_ index: Index) -> Element? { fatalError() }
    
    @available(*, unavailable, message:"Use insertElement(_:at:) instead")
    public mutating func insertElementWithKey(_ key: Key, value: Value, atIndex index: Index) -> Value? { fatalError() }
    
    @available(*, unavailable, renamed:"insert(_:at:)")
    public mutating func insertElement(_ newElement: Element, atIndex index: Index) -> Value? { fatalError() }
    
    @available(*, unavailable, renamed:"remove(at:)")
    public mutating func removeAtIndex(_ index: Index) -> Element? { fatalError() }
    
}
