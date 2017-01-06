extension OrderedDictionary {
    
    @available(*, unavailable, renamed:"value(forKey:)")
    public func valueForKey(_ key: Key) -> Value? { fatalError() }
    
    @available(*, unavailable, renamed:"removeValue(forKey:)")
    public mutating func removeValueForKey(_ key: Key) -> Value? { fatalError() }
    
    @available(*, unavailable, renamed:"removeAll(keepingCapacity:)")
    public mutating func removeAll(keepCapacity: Bool) -> Value? { fatalError() }
    
}
