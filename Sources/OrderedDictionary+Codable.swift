extension OrderedDictionary: Encodable /* where Key: Encodable, Value: Encodable */ {
    
    /// __inheritdoc__
    public func encode(to encoder: Encoder) throws {
        assertTypeIsEncodable(Key.self, in: type(of: self))
        assertTypeIsEncodable(Value.self, in: type(of: self))
        
        var container = encoder.unkeyedContainer()
        
        for (key, value) in self {
            // Using the magic desribed here:
            // https://github.com/apple/swift/blob/master/stdlib/public/core/Codable.swift#L4114-L4116
            let keyEncoder = container.superEncoder()
            try (key as! Encodable).encode(to: keyEncoder)
            
            let valueEncoder = container.superEncoder()
            try (value as! Encodable).encode(to: valueEncoder)
        }
    }
    
    /// This assertion is used for checking the conformance to `Encodable` of `Key` and `Value`
    /// types in `OrderedDictionary`. This workaround is necessary due to the limitation of missing
    /// conditional protocol conformance in Swift.
    ///
    /// The code is take from the Swift repository:
    /// https://github.com/apple/swift/blob/master/stdlib/public/core/Codable.swift#L3963-L3981
    private func assertTypeIsEncodable<T>(_ type: T.Type, in wrappingType: Any.Type) {
        guard T.self is Encodable.Type else {
            if T.self == Encodable.self || T.self == Codable.self {
                preconditionFailure("\(wrappingType) does not conform to Encodable because Encodable does not conform to itself. You must use a concrete type to encode or decode.")
            } else {
                preconditionFailure("\(wrappingType) does not conform to Encodable because \(T.self) does not conform to Encodable.")
            }
        }
    }
    
}

extension OrderedDictionary: Decodable /* where Key: Decodable, Value: Decodable */ {
    
    /// __inheritdoc__
    public init(from decoder: Decoder) throws {
        self.init()
        
        assertTypeIsDecodable(Key.self, in: type(of: self))
        assertTypeIsDecodable(Value.self, in: type(of: self))
        
        var container = try decoder.unkeyedContainer()
        
        let keyMetaType = (Key.self as! Decodable.Type)
        let valueMetaType = (Value.self as! Decodable.Type)
        
        while !container.isAtEnd {
            // Using the magic desribed here:
            // https://github.com/apple/swift/blob/master/stdlib/public/core/Codable.swift#L4181-L4184
            let keyDecoder = try container.superDecoder()
            let key = try keyMetaType.init(from: keyDecoder) as! Key
            
            guard !container.isAtEnd else {
                let error = DecodingError.Context(codingPath: decoder.codingPath,
                                                  debugDescription: "Unkeyed container reached end before value in key-value pair.")
                throw DecodingError.dataCorrupted(error)
            }
            
            let valueDecoder = try container.superDecoder()
            let value = try valueMetaType.init(from: valueDecoder) as! Value
            
            self[key] = value
        }
    }
    
    /// This assertion is used for checking the conformance to `Decodable` of `Key` and `Value`
    /// types in `OrderedDictionary`. This workaround is necessary due to the limitation of missing
    /// conditional protocol conformance in Swift.
    ///
    /// The code is take from the Swift repository:
    /// https://github.com/apple/swift/blob/master/stdlib/public/core/Codable.swift#L3963-L3981
    private func assertTypeIsDecodable<T>(_ type: T.Type, in wrappingType: Any.Type) {
        guard T.self is Decodable.Type else {
            if T.self == Decodable.self || T.self == Codable.self {
                preconditionFailure("\(wrappingType) does not conform to Decodable because Decodable does not conform to itself. You must use a concrete type to encode or decode.")
            } else {
                preconditionFailure("\(wrappingType) does not conform to Decodable because \(T.self) does not conform to Decodable.")
            }
        }
    }
    
}
