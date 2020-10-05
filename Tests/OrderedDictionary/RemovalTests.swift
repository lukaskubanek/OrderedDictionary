import Foundation
import OrderedDictionary
import XCTest

class RemovalTests: XCTestCase {
    
    // ============================================================================ //
    // MARK: - Key-based Removal Via removeValue(forKey:)
    // ============================================================================ //
    
    func testKeyBasedRemoval_viaMethod_existingKey() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let value = orderedDictionary.removeValue(forKey: "b")
        
        XCTAssertEqual(value, 2)
        XCTAssertEqual(orderedDictionary, ["a": 1, "c": 3])
    }
    
    func testKeyBasedRemoval_viaMethod_invalidKey() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let value = orderedDictionary.removeValue(forKey: "d")
        
        XCTAssertNil(value)
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2, "c": 3])
    }
    
    // ============================================================================ //
    // MARK: - Key-based Removal Via subscript(key:)
    // ============================================================================ //
    
    func testKeyBasedRemoval_viaSubscript_existingKey() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        orderedDictionary["b"] = nil
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "c": 3])
    }
    
    func testKeyBasedRemoval_viaSubscript_invalidKey() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        orderedDictionary["d"] = nil
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2, "c": 3])
    }
    
    // ============================================================================ //
    // MARK: - Index-based Removal Via Method
    // ============================================================================ //
    
    func testIndexBasedRemoval_viaMethod_validIndex() throws {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let (key, value) = try XCTUnwrap(orderedDictionary.remove(at: 2))
        
        XCTAssertEqual(key, "c")
        XCTAssertEqual(value, 3)
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2])
    }
    
    func testIndexBasedRemoval_viaMethod_invalidIndex() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let element = orderedDictionary.remove(at: 5)
        
        XCTAssertNil(element)
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2, "c": 3])
    }
    
    // ============================================================================ //
    // MARK: - Remove All
    // ============================================================================ //
    
    func testRemoveAll() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        orderedDictionary.removeAll()
        
        XCTAssertEqual(orderedDictionary, [])
    }
    
    // ============================================================================ //
    // MARK: - Pop First & Last
    // ============================================================================ //
    
    func testPopFirstEmpty() {
        var orderedDictionary: OrderedDictionary<String, Int> = []
        
        let first = orderedDictionary.popFirst()
        
        XCTAssertNil(first)
    }
    
    func testPopFirstNonEmpty() throws {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        let first = try XCTUnwrap(orderedDictionary.popFirst())
        
        XCTAssertEqual(first.key, "a")
        XCTAssertEqual(first.value, 1)
        
        XCTAssertEqual(orderedDictionary, ["b": 2, "c": 3, "d": 4])
    }
    
    func testPopLastEmpty() {
        var orderedDictionary: OrderedDictionary<String, Int> = []
        
        let last = orderedDictionary.popLast()
        
        XCTAssertNil(last)
    }
    
    func testPopLastNonEmpty() throws {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        let last = try XCTUnwrap(orderedDictionary.popLast())
        
        XCTAssertEqual(last.key, "d")
        XCTAssertEqual(last.value, 4)
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2, "c": 3])
    }
    
    // ============================================================================ //
    // MARK: - Removal First & Last
    // ============================================================================ //
    
    func testRemoveFirstNonEmpty() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        let first = orderedDictionary.removeFirst()
        
        XCTAssertEqual(first.key, "a")
        XCTAssertEqual(first.value, 1)
        
        XCTAssertEqual(orderedDictionary, ["b": 2, "c": 3, "d": 4])
    }
    
    func testRemoveLastNonEmpty() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3, "d": 4]
        
        let last = orderedDictionary.removeLast()
        
        XCTAssertEqual(last.key, "d")
        XCTAssertEqual(last.value, 4)
        
        XCTAssertEqual(orderedDictionary, ["a": 1, "b": 2, "c": 3])
    }
    
}
