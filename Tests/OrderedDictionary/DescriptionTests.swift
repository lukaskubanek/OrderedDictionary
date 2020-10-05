import Foundation
import OrderedDictionary
import XCTest

struct DescribedValue: CustomStringConvertible, CustomDebugStringConvertible {
    init(_ value: Int) { self.value = value }
    let value: Int
    var description: String { return "\(value)" }
    var debugDescription: String { return "debug(\(value))" }
}

class DescriptionTests: XCTestCase {
    
    func testEmptyDescription() {
        let orderedDictionary = OrderedDictionary<String, DescribedValue>()
        
        XCTAssertEqual(orderedDictionary.description, "[:]")
    }
    
    func testDescription() {
        let orderedDictionary: OrderedDictionary = [
            "a": DescribedValue(1),
            "b": DescribedValue(2),
            "c": DescribedValue(3)
        ]
        
        XCTAssertEqual(orderedDictionary.description, "[a: 1, b: 2, c: 3]")
    }
    
    func testEmptyDebugDescription() {
        let orderedDictionary = OrderedDictionary<String, DescribedValue>()
        
        XCTAssertEqual(orderedDictionary.debugDescription, "[:]")
    }
    
    func testDebugDescription() {
        let orderedDictionary: OrderedDictionary = [
            "a": DescribedValue(1),
            "b": DescribedValue(2),
            "c": DescribedValue(3)
        ]
        
        XCTAssertEqual(
            orderedDictionary.debugDescription,
            "[\"a\": debug(1), \"b\": debug(2), \"c\": debug(3)]"
        )
    }
    
}
