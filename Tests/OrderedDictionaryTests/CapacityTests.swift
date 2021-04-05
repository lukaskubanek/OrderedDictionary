import Foundation
import OrderedDictionary
import XCTest

class CapacityTests: XCTestCase {
    
    func testCapacityReservationViaInit() {
        let orderedDictionary = OrderedDictionary<String, Int>(minimumCapacity: 10)
        
        XCTAssertGreaterThanOrEqual(orderedDictionary.capacity, 10)
    }
    
    func testCapacityReservationViaMethod() {
        var orderedDictionary = OrderedDictionary<String, Int>()
        
        XCTAssertEqual(orderedDictionary.capacity, 0)
        
        orderedDictionary.reserveCapacity(10)
        
        XCTAssertGreaterThanOrEqual(orderedDictionary.capacity, 10)
        XCTAssertLessThan(orderedDictionary.capacity, 20)
        
        orderedDictionary.reserveCapacity(20)
        
        XCTAssertGreaterThanOrEqual(orderedDictionary.capacity, 20)
    }
    
    func testCapacityGrowForElementInsertion() {
        var orderedDictionary = OrderedDictionary<String, Int>()
        
        XCTAssertEqual(orderedDictionary.capacity, 0)
        
        orderedDictionary["a"] = 1
        
        XCTAssertEqual(orderedDictionary.capacity, 1)
        
        orderedDictionary["b"] = 2
        orderedDictionary["a"] = 3
        
        XCTAssertEqual(orderedDictionary.capacity, 2)
    }
    
}
