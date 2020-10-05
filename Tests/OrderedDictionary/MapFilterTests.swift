import Foundation
import OrderedDictionary
import XCTest

class MapFilterTests: XCTestCase {
    
    func testMapValues() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        XCTAssertEqual(
            orderedDictionary.mapValues { String($0) },
            ["a": "1", "b": "2", "c": "3", "d": "4"]
        )
    }
    
    func testCompactMapValues() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        XCTAssertEqual(
            orderedDictionary.compactMapValues { $0 % 2 == 0 ? String($0) : nil },
            ["b": "2", "d": "4"]
        )
    }
    
}
