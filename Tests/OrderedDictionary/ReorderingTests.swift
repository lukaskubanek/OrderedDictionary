import Foundation
import OrderedDictionary
import XCTest

class ReorderingTests: XCTestCase {
    
    func testSwapAtDifferentIndices() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        orderedDictionary.swapAt(1, 3)
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "d": 4, "c": 3, "b": 2])
    }
    
    func testSwapAtSameIndex() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        orderedDictionary.swapAt(0, 0)
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2, "c": 3, "d": 4])
    }
    
    func testPartitioning() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        let index = orderedDictionary.partition(by: { $0.value % 2 == 0 })
        
        XCTAssertEqual(index, 2)
        XCTAssertEqual(orderedDictionary, ["a": 1, "c": 3, "b": 2, "d": 4])
    }
    
    func testReversal() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        orderedDictionary.reverse()
        
        XCTAssertEqual(orderedDictionary, ["d": 4, "c": 3, "b": 2, "a": 1])
    }
    
}
