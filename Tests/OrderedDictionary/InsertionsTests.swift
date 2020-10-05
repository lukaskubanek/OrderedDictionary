import Foundation
import OrderedDictionary
import XCTest

class InsertionsTests: XCTestCase {
    
    // ============================================================================ //
    // MARK: - Index-based Insertion
    // ============================================================================ //
    
    func testIndexBasedInsertion_uniqueKey_startIndex() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let newElement = (key: "d", value: 4)
        orderedDictionary.insert(newElement, at: 0)
        XCTAssertEqual(orderedDictionary, ["d": 4, "a": 1, "b": 2, "c": 3])
    }
    
    func testIndexBasedInsertion_uniqueKey_middleIndex() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let newElement = (key: "d", value: 4)
        orderedDictionary.insert(newElement, at: 2)
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2, "d": 4, "c": 3])
    }
    
    func testIndexBasedInsertion_uniqueKey_endIndex() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let newElement = (key: "d", value: 4)
        orderedDictionary.insert(newElement, at: 3)
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2, "c": 3, "d": 4])
    }
    
    func testIndexBasedInsertion_duplicateKey() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        XCTAssertFalse(orderedDictionary.canInsert(key: "a"))
        XCTAssertTrue(orderedDictionary.canInsert(key: "d"))
    }
    
    func testIndexBasedInsertion_invalidIndex() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        XCTAssertFalse(orderedDictionary.canInsert(at: -1))
        XCTAssertFalse(orderedDictionary.canInsert(at: 4))
    }
    
    // ============================================================================ //
    // MARK: - Key-based Insertion
    // ============================================================================ //
    
    func testKeyBasedInsertion() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        orderedDictionary["d"] = 4
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2, "c": 3, "d": 4])
    }
    
}
