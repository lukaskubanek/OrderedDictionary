extension OrderedDictionary {
    
    @available(*, unavailable, renamed:"contains(key:)")
    public func containsKey(_ key: Key) { fatalError() }
    
    @available(*, unavailable, renamed:"value(forKey:)")
    public func valueForKey(_ key: Key) -> Value? { fatalError() }
    
}
