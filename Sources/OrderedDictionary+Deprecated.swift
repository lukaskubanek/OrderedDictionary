extension OrderedDictionary {
    
    @available(*, deprecated, message: "Please use init(values:uniquelyKeyedBy:).", renamed: "init(values:uniquelyKeyedBy:)")
    public init<S: Sequence>(
        values: S,
        keyedBy extractKey: (Value) -> Key
    ) where S.Element == Value {
        self.init(values: values, uniquelyKeyedBy: extractKey)
    }
    
    @available(*, deprecated, message: "Please use init(values:uniquelyKeyedBy:).", renamed: "init(values:uniquelyKeyedBy:)")
    public init(
        values: [Value],
        keyedBy keyPath: KeyPath<Value, Key>
    ) {
        self.init(values: values, uniquelyKeyedBy: keyPath)
    }
    
    @available(*, deprecated, message: "Please use init(uniqueKeysWithValues:).", renamed: "init(uniqueKeysWithValues:)")
    public init<S: Sequence>(_ elements: S) where S.Element == Element {
        self.init(uniqueKeysWithValues: elements)
    }
    
}
