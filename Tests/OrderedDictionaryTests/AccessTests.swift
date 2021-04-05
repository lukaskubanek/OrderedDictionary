import Foundation
import OrderedDictionary
import XCTest

class AccessTests: XCTestCase {
    
    func testAccessBasic() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertFalse(orderedDictionary.isEmpty)
        
        XCTAssertEqual(orderedDictionary.indices, 0..<3)
        XCTAssertEqual(orderedDictionary.startIndex, 0)
        XCTAssertEqual(orderedDictionary.endIndex, 3)
        
        XCTAssertEqual(orderedDictionary[0].key, "a")
        XCTAssertEqual(orderedDictionary[1].key, "b")
        XCTAssertEqual(orderedDictionary[2].key, "c")
        
        XCTAssertTrue(orderedDictionary.containsKey("a"))
        XCTAssertTrue(orderedDictionary.containsKey("b"))
        XCTAssertTrue(orderedDictionary.containsKey("c"))
        
        XCTAssertEqual(orderedDictionary["a"], 1)
        XCTAssertEqual(orderedDictionary["b"], 2)
        XCTAssertEqual(orderedDictionary["c"], 3)
        
        XCTAssertEqual(orderedDictionary.value(forKey: "a"), 1)
        XCTAssertEqual(orderedDictionary.value(forKey: "b"), 2)
        XCTAssertEqual(orderedDictionary.value(forKey: "c"), 3)
        
        XCTAssertEqual(orderedDictionary.index(forKey: "a"), 0)
        XCTAssertEqual(orderedDictionary.index(forKey: "b"), 1)
        XCTAssertEqual(orderedDictionary.index(forKey: "c"), 2)
        
        XCTAssertNotNil(orderedDictionary.elementAt(0))
        XCTAssertNotNil(orderedDictionary.elementAt(1))
        XCTAssertNotNil(orderedDictionary.elementAt(2))
    }
    
    func testAccessSlice() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        let slice = orderedDictionary[2..<4]
        
        XCTAssertEqual(slice.count, 2)
        XCTAssertFalse(slice.isEmpty)
        
        XCTAssertEqual(slice.indices, 2..<4)
        XCTAssertEqual(slice.startIndex, 2)
        XCTAssertEqual(slice.endIndex, 4)
        
        XCTAssertEqual(orderedDictionary[2].key, "c")
        XCTAssertEqual(orderedDictionary[3].key, "d")
    }
    
    func testAccessOrderedKeys() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        XCTAssertEqual(
            orderedDictionary.orderedKeys,
            ["a", "b", "c"]
        )
    }
    
    func testAccessOrderedValues() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        XCTAssertEqual(
            Array(orderedDictionary.orderedValues),
            [1, 2, 3]
        )
    }
    
    func testAccessElementAtInvalidIndex() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        XCTAssertNil(orderedDictionary.elementAt(-1))
        XCTAssertNil(orderedDictionary.elementAt(3))
    }
    
    func testAccessUnsortedDictionary() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        XCTAssertEqual(
            orderedDictionary.unorderedDictionary,
            ["a": 1, "b": 2, "c": 3]
        )
    }
    
    func testIteratorInForLoop() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        var keys = [String]()
        var values = [Int]()
        
        for (key, value) in orderedDictionary {
            keys.append(key)
            values.append(value)
        }
        
        XCTAssertEqual(keys, ["a", "b", "c"])
        XCTAssertEqual(values, [1, 2, 3])
    }
    
}
