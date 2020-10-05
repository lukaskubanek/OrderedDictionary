import Foundation
import OrderedDictionary
import XCTest

class UpdatesTests: XCTestCase {
    
    // ============================================================================ //
    // MARK: - Index-based Updates Via update(_:at:)
    // ============================================================================ //
    
    func testIndexBasedUpdate_viaMethod_sameKey() throws {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let newElement = (key: "b", value: 0)
        let previousElement = try XCTUnwrap(orderedDictionary.update(newElement, at: 1))
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 0, "c": 3])
        
        XCTAssertEqual(previousElement.key, "b")
        XCTAssertEqual(previousElement.value, 2)
    }
    
    func testIndexBasedUpdate_viaMethod_newUniqueKey() throws {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let newElement = (key: "d", value: 0)
        let previousElement = try XCTUnwrap(orderedDictionary.update(newElement, at: 1))
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "d": 0, "c": 3])
        
        XCTAssertEqual(previousElement.key, "b")
        XCTAssertEqual(previousElement.value, 2)
    }
    
    func testIndexBasedUpdate_viaMethod_duplicateKey() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let element = (key: "a", value: 42)
        
        XCTAssertTrue(orderedDictionary.canUpdate(element, at: 0))
        XCTAssertFalse(orderedDictionary.canUpdate(element, at: 1))
        XCTAssertFalse(orderedDictionary.canUpdate(element, at: 2))
    }
    
    // ============================================================================ //
    // MARK: - Index-based Updates Via subscript(position:)
    // ============================================================================ //
    
    func testIndexBasedUpdate_viaSubscript_single_sameKey() throws {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        orderedDictionary[1] = (key: "b", value: 0)
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 0, "c": 3])
    }
    
    func testIndexBasedUpdate_viaSubscript_single_newUniqueKey() throws {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        orderedDictionary[1] = (key: "d", value: 0)
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "d": 0, "c": 3])
    }
    
    // ============================================================================ //
    // MARK: - Index-based Updates Via subscript(bounds:)
    // ============================================================================ //
    
    func testIndexBasedUpdate_viaSubscript_multiple() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let sliceOrderedDictionary: OrderedDictionary<String, Int> = ["d": 0, "e": 0]
        let slice = sliceOrderedDictionary[0..<2]
        
        orderedDictionary[1..<3] = slice
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "d": 0, "e": 0])
    }
    
    // ============================================================================ //
    // MARK: - Key-based Updates
    // ============================================================================ //
    
    func testKeyBasedUpdate() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        // Update
        orderedDictionary["a"] = 5
        XCTAssertEqual(orderedDictionary, ["a": 5, "b": 2, "c": 3])
        
        // Insertion
        orderedDictionary["d"] = 10
        XCTAssertEqual(orderedDictionary, ["a": 5, "b": 2, "c": 3, "d": 10])
        XCTAssertTrue(orderedDictionary.containsKey("d"))
        
        // Removal
        orderedDictionary["b"] = nil
        XCTAssertEqual(orderedDictionary, ["a": 5, "c": 3, "d": 10])
        XCTAssertFalse(orderedDictionary.containsKey("b"))
    }
    
}
