extension OrderedDictionary: CustomStringConvertible {
    
    public var description: String {
        return constructDescription(debug: false)
    }
    
}

extension OrderedDictionary: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return constructDescription(debug: true)
    }
    
}

extension OrderedDictionary {
    
    fileprivate func constructDescription(debug: Bool) -> String {
        // The implementation of the description is inspired by zwaldowski's implementation of the ordered dictionary.
        // See http://bit.ly/1VL4JUR
        
        if isEmpty { return "[:]" }
        
        let printFunction: (Any, inout String) -> () = {
            if debug {
                return { debugPrint($0, separator: "", terminator: "", to: &$1) }
            } else {
                return { print($0, separator: "", terminator: "", to: &$1) }
            }
        }()
        
        let descriptionForItem: (Any) -> String = { item in
            var description = ""
            printFunction(item, &description)
            return description
        }
        
        let bodyComponents = map { element in
            return descriptionForItem(element.key) + ": " + descriptionForItem(element.value)
        }
        
        let body = bodyComponents.joined(separator: ", ")
        
        return "[\(body)]"
    }
    
}
