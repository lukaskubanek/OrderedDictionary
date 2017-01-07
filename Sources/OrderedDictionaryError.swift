public enum OrderedDictionaryError: Error {
    
    case nonUniqueKey(AnyHashable)
    
}

extension OrderedDictionaryError: Equatable {
    
    public static func == (lhs: OrderedDictionaryError, rhs: OrderedDictionaryError) -> Bool {
        switch (lhs, rhs) {
        case let (.nonUniqueKey(key1), .nonUniqueKey(key2)):
            return key1 == key2
        }
    }
    
}
