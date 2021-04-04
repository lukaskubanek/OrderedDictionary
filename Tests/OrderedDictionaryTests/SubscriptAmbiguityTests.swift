import Foundation
import OrderedDictionary
import XCTest

// See #49
class SubscriptAmbiguityTests: XCTestCase {
    
    func testAccess() {
        let orderedDictionary: OrderedDictionary<Int, String> = [1: "a", 2: "b", 3: "c"]
        
        let valueForKey = orderedDictionary[1] as String?
        let elementAtIndex = orderedDictionary[1] as (key: Int, value: String)
        
        XCTAssertEqual(valueForKey, "a")
        XCTAssertEqual(elementAtIndex.key, 2)
        XCTAssertEqual(elementAtIndex.value, "b")
    }
    
    func testIndexBasedUpdate() {
        var orderedDictionary: OrderedDictionary<Int, String> = [1: "a", 2: "b", 3: "c"]
        
        orderedDictionary[1] = (key: 2, value: "x")
        
        XCTAssertEqual(orderedDictionary, [1: "a", 2: "x", 3: "c"])
    }
    
    func testKeyBasedUpdate() {
        var orderedDictionary: OrderedDictionary<Int, String> = [1: "a", 2: "b", 3: "c"]
        
        orderedDictionary[1] = "x"
        
        XCTAssertEqual(orderedDictionary, [1: "x", 2: "b", 3: "c"])
    }
    
}
