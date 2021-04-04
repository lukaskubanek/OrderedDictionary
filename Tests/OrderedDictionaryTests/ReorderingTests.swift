import Foundation
import OrderedDictionary
import XCTest

class ReorderingTests: XCTestCase {
    
    // ============================================================================ //
    // MARK: - Reversal
    // ============================================================================ //
    
    func testReversal() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        orderedDictionary.reverse()
        
        XCTAssertEqual(orderedDictionary, ["d": 4, "c": 3, "b": 2, "a": 1])
    }
    
    func testReversal_throughSlice() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        orderedDictionary[1..<3].reverse()
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "c": 3, "b": 2, "d": 4])
    }
    
    // ============================================================================ //
    // MARK: - Partitioning
    // ============================================================================ //
    
    func testPartitioning() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        let index = orderedDictionary.partition(by: { $0.value.isMultiple(of: 2) })
        
        XCTAssertEqual(index, 2)
        XCTAssertEqual(orderedDictionary, ["a": 1, "c": 3, "b": 2, "d": 4])
    }
    
    func testPartitioning_throughSlice() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        let index = orderedDictionary[0..<3].partition(by: { !$0.value.isMultiple(of: 2) })
        
        XCTAssertEqual(index, 1)
        XCTAssertEqual(orderedDictionary, ["b": 2, "a": 1, "c": 3, "d": 4])
    }
    
    // ============================================================================ //
    // MARK: - Swapping
    // ============================================================================ //
    
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
    
    func testSwapAtDifferentIndices_throughSlice() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        orderedDictionary[1..<4].swapAt(1, 3)
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "d": 4, "c": 3, "b": 2])
    }
    
    func testSwapAtSameIndex_throughSlice() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        orderedDictionary[0..<1].swapAt(0, 0)
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2, "c": 3, "d": 4])
    }
    
}
