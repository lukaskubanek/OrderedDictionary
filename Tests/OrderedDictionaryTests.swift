//
//  OrderedDictionaryTests.swift
//  OrderedDictionaryTests
//
//  Created by Lukas Kubanek on 29/08/15.
//  Copyright © 2015 Lukas Kubanek. All rights reserved.
//

import XCTest
import OrderedDictionary

class OrderedDictionaryTests: XCTestCase {
    
    var orderedDictionary: OrderedDictionary<String, Int>!
    
    override func setUp() {
        orderedDictionary = [
            ("A", 1),
            ("B", 2),
            ("C", 3)
        ]
    }
    
    // ======================================================= //
    // MARK: - Content
    // ======================================================= //
    
    func testInitializedContent() {
        XCTAssertEqual(orderedDictionary.count, 3)
        
        XCTAssertEqual(orderedDictionary["A"], 1)
        XCTAssertEqual(orderedDictionary.indexForKey("A"), 0)
        XCTAssertTrue(orderedDictionary.containsKey("A"))
        
        XCTAssertEqual(orderedDictionary["B"], 2)
        XCTAssertEqual(orderedDictionary.indexForKey("B"), 1)
        XCTAssertTrue(orderedDictionary.containsKey("B"))
        
        XCTAssertEqual(orderedDictionary["C"], 3)
        XCTAssertEqual(orderedDictionary.indexForKey("C"), 2)
        XCTAssertTrue(orderedDictionary.containsKey("C"))
    }
    
    func testInitializationUsingPairs() {
        let elements = [
            ("A", 1),
            ("B", 2),
            ("C", 3)
        ]
        
        XCTAssertTrue(OrderedDictionary(elements: elements) == orderedDictionary)
    }
    
    func testElementsGenerator() {
        for entry in orderedDictionary.enumerate() {
            XCTAssertEqual(orderedDictionary[entry.index].0, entry.element.0)
            XCTAssertEqual(orderedDictionary[entry.index].1, entry.element.1)
        }
    }
    
    func testOrderedKeysAndValues() {
        XCTAssertEqual(orderedDictionary.orderedKeys, ["A", "B", "C"])
        XCTAssertEqual(orderedDictionary.orderedValues, [1, 2, 3])
    }
    
    // ======================================================= //
    // MARK: - Key-based Modifications
    // ======================================================= //
    
    func testKeyBasedSubscript() {
        orderedDictionary["A"] = 5
        orderedDictionary["D"] = 10
        orderedDictionary["B"] = nil
        
        XCTAssertEqual(orderedDictionary.count, 3)
        
        XCTAssertEqual(orderedDictionary["A"], 5)
        XCTAssertEqual(orderedDictionary.indexForKey("A"), 0)
        XCTAssertTrue(orderedDictionary.containsKey("A"))
        
        XCTAssertNil(orderedDictionary["B"])
        XCTAssertNil(orderedDictionary.indexForKey("B"))
        XCTAssertFalse(orderedDictionary.containsKey("B"))
        
        XCTAssertEqual(orderedDictionary["C"], 3)
        XCTAssertEqual(orderedDictionary.indexForKey("C"), 1)
        XCTAssertTrue(orderedDictionary.containsKey("C"))
        
        XCTAssertEqual(orderedDictionary["D"], 10)
        XCTAssertEqual(orderedDictionary.indexForKey("D"), 2)
        XCTAssertTrue(orderedDictionary.containsKey("D"))
    }
    
    // ======================================================= //
    // MARK: - Index-based Modifications
    // ======================================================= //
    
    func testIndexBasedSubscriptForRetrievingValues() {
        let elementAtIndex0 = orderedDictionary[0]
        XCTAssertEqual(elementAtIndex0.0, "A")
        XCTAssertEqual(elementAtIndex0.1, 1)
        
        let elementAtIndex1 = orderedDictionary[1]
        XCTAssertEqual(elementAtIndex1.0, "B")
        XCTAssertEqual(elementAtIndex1.1, 2)
        
        let elementAtIndex2 = orderedDictionary[2]
        XCTAssertEqual(elementAtIndex2.0, "C")
        XCTAssertEqual(elementAtIndex2.1, 3)
    }
    
    func testIndexBasedSubscriptForSettingValues() {
        orderedDictionary[0] = ("F", 10)
        orderedDictionary[1] = ("B", 5)
        
        let elementAtIndex0 = orderedDictionary[0]
        XCTAssertEqual(elementAtIndex0.0, "F")
        XCTAssertEqual(elementAtIndex0.1, 10)
        
        let elementAtIndex1 = orderedDictionary[1]
        XCTAssertEqual(elementAtIndex1.0, "B")
        XCTAssertEqual(elementAtIndex1.1, 5)
        
        let elementAtIndex2 = orderedDictionary[2]
        XCTAssertEqual(elementAtIndex2.0, "C")
        XCTAssertEqual(elementAtIndex2.1, 3)
    }
    
    func testRetrievingElementAtNonExistentIndex() {
        XCTAssertNil(orderedDictionary.elementAtIndex(10))
    }
    
    func testIndexBasedInsertionsOfElementsWithDistinctKeys() {
        orderedDictionary.insertElement(("T", 15), atIndex: 0)
        orderedDictionary.insertElement(("U", 16), atIndex: 2)
        orderedDictionary.insertElement(("V", 17), atIndex: 5)
        orderedDictionary.insertElement(("W", 18), atIndex: 2)
        
        let XCTAssertEqualedOrderedDictionary: OrderedDictionary<String, Int> = [
            ("T", 15),
            ("A", 1),
            ("W", 18),
            ("U", 16),
            ("B", 2),
            ("C", 3),
            ("V", 17)
        ]
        
        XCTAssertTrue(orderedDictionary == XCTAssertEqualedOrderedDictionary)
    }
    
    func testIndexBasedInsertionOfElementWithSameKeyBeforeItsCurrentIndex() {
        let previousValue = orderedDictionary.insertElement(("B", 5), atIndex: 0)
        
        let expectedOrderedDictionary: OrderedDictionary<String, Int> = [
            ("B", 5),
            ("A", 1),
            ("C", 3)
        ]
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertTrue(orderedDictionary == expectedOrderedDictionary)
        XCTAssertEqual(previousValue, 2)
    }
    
    func testIndexBasedInsertionOfElementWithSameKeyAtItsCurrentIndex() {
        let previousValue = orderedDictionary.insertElement(("B", 5), atIndex: 1)
        
        let expectedOrderedDictionary: OrderedDictionary<String, Int> = [
            ("A", 1),
            ("B", 5),
            ("C", 3)
        ]
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertTrue(orderedDictionary == expectedOrderedDictionary)
        XCTAssertEqual(previousValue, 2)
    }
    
    func testIndexBasedInsertionOfElementWithSameKeyAfterItsCurrentIndex() {
        let previousValue = orderedDictionary.insertElement(("B", 5), atIndex: 3)
        
        let expectedOrderedDictionary: OrderedDictionary<String, Int> = [
            ("A", 1),
            ("C", 3),
            ("B", 5)
        ]
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertTrue(orderedDictionary == expectedOrderedDictionary)
        XCTAssertEqual(previousValue, 2)
    }
    
    // ======================================================= //
    // MARK: - Removal
    // ======================================================= //
    
    func testRemoveAll() {
        orderedDictionary.removeAll()
        
        XCTAssertEqual(orderedDictionary.count, 0)
    }
    
    func testRemovalForKey() {
        let removedValue1 = orderedDictionary.removeValueForKey("A")
        let removedValue2 = orderedDictionary.removeValueForKey("K")
        
        XCTAssertEqual(removedValue1, 1)
        XCTAssertNil(removedValue2)
        
        XCTAssertEqual(orderedDictionary.count, 2)
        
        XCTAssertNil(orderedDictionary["A"])
        XCTAssertNil(orderedDictionary.indexForKey("A"))
        
        XCTAssertEqual(orderedDictionary["B"], 2)
        XCTAssertEqual(orderedDictionary.indexForKey("B"), 0)
        
        XCTAssertEqual(orderedDictionary["C"], 3)
        XCTAssertEqual(orderedDictionary.indexForKey("C"), 1)

    }
    
    func testRemovalAtIndex() {
        let removedElement1 = orderedDictionary.removeAtIndex(1)
        let removedElement2 = orderedDictionary.removeAtIndex(0)
        let removedElement3 = orderedDictionary.removeAtIndex(5)
        
        XCTAssertEqual(removedElement1?.0, "B")
        XCTAssertEqual(removedElement1?.1, 2)
        
        XCTAssertEqual(removedElement2?.0, "A")
        XCTAssertEqual(removedElement2?.1, 1)
        
        XCTAssertNil(removedElement3)
        
        XCTAssertEqual(orderedDictionary.count, 1)
        
        let elementAtIndex0 = orderedDictionary[0]
        XCTAssertEqual(elementAtIndex0.0, "C")
        XCTAssertEqual(elementAtIndex0.1, 3)
    }
    
    func testSort() {
        self.orderedDictionary.sort {(item1, item2) in
            return item1.0 > item2.0
        }
        
        let expectedOrderedDictionary: OrderedDictionary<String, Int> = [
            ("C", 3),
            ("B", 2),
            ("A", 1)
        ]
        
        XCTAssertTrue(self.orderedDictionary == expectedOrderedDictionary)
    }
    
    // ======================================================= //
    // MARK: - Sorting
    // ======================================================= //
    
    func testSortingInPlace() {
        var testOrderedDictionary: OrderedDictionary<String, Int> = [
            ("E", 4),
            ("G", 3),
            ("A", 3),
            ("D", 1),
            ("B", 4)
        ]
        
        testOrderedDictionary.sortInPlace { (item1, item2) in
            if item1.1 == item2.1 {
                return item1.0 < item2.0
            } else {
                return item1.1 < item2.1
            }
        }
        
        let expectedOrderedDictionary: OrderedDictionary<String, Int> = [
            ("D", 1),
            ("A", 3),
            ("G", 3),
            ("B", 4),
            ("E", 4)
        ]
        
        XCTAssertTrue(testOrderedDictionary == expectedOrderedDictionary)
    }
    
    // ======================================================= //
    // MARK: - Description
    // ======================================================= //
    
    func testDescription() {
        XCTAssertEqual(orderedDictionary.description, "[A: 1, B: 2, C: 3]")
    }
    
}
