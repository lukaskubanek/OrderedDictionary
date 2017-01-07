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
    
}
