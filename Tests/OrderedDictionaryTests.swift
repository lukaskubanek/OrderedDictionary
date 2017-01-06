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
    
    // ======================================================= //
    // MARK: - Initialization
    // ======================================================= //
    
    func testInitializationUsingArrayLiteral() {
        let expected = OrderedDictionary<String, Int>(elements: [("A", 1), ("B", 2), ("C", 3)])
        let actual: OrderedDictionary<String, Int> = [("A", 1), ("B", 2), ("C", 3)]
        
        XCTAssertTrue(expected == actual)
    }
    
    func testInitializationUsingDictionaryLiteral() {
        let expected = OrderedDictionary<String, Int>(elements: [("A", 1), ("B", 2), ("C", 3)])
        let actual: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        XCTAssertTrue(expected == actual)
    }
    
    // ======================================================= //
    // MARK: - Description
    // ======================================================= //
    
    struct DescribedValue: CustomStringConvertible, CustomDebugStringConvertible {
        init(_ value: Int) { self.value = value }
        let value: Int
        var description: String { return "\(value)" }
        var debugDescription: String { return "debug(\(value))" }
    }
    
    func testEmptyDescription() {
        let expected = "[:]"
        
        let orderedDictionary = OrderedDictionary<String, DescribedValue>()
        let actual = orderedDictionary.description
        
        XCTAssertEqual(expected, actual)
    }
    
    func testDescription() {
        let expected = "[A: 1, B: 2, C: 3]"
        
        let orderedDictionary: OrderedDictionary<String, DescribedValue> = ["A": DescribedValue(1), "B": DescribedValue(2), "C": DescribedValue(3)]
        let actual = orderedDictionary.description
        
        XCTAssertEqual(expected, actual)
    }
    
    func testEmptyDebugDescription() {
        let expected = "[:]"
        
        let orderedDictionary = OrderedDictionary<String, DescribedValue>()
        let actual = orderedDictionary.debugDescription
        
        XCTAssertEqual(expected, actual)
    }
    
    func testDebugDescription() {
        let expected = "[\"A\": debug(1), \"B\": debug(2), \"C\": debug(3)]"
        
        let orderedDictionary: OrderedDictionary<String, DescribedValue> = ["A": DescribedValue(1), "B": DescribedValue(2), "C": DescribedValue(3)]
        let actual = orderedDictionary.debugDescription
        
        XCTAssertEqual(expected, actual)
    }
    
    // ======================================================= //
    // MARK: - Content Access
    // ======================================================= //
    
    func testAccessingContent() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        XCTAssertEqual(orderedDictionary.count, 3)
        
        XCTAssertEqual(orderedDictionary["A"], 1)
        XCTAssertEqual(orderedDictionary.value(forKey: "A"), 1)
        XCTAssertEqual(orderedDictionary.indexForKey("A"), 0)
        XCTAssertTrue(orderedDictionary.contains(key: "A"))
        XCTAssertTrue(orderedDictionary[0] == ("A", 1))
        
        XCTAssertEqual(orderedDictionary["B"], 2)
        XCTAssertEqual(orderedDictionary.value(forKey: "B"), 2)
        XCTAssertEqual(orderedDictionary.indexForKey("B"), 1)
        XCTAssertTrue(orderedDictionary.contains(key: "B"))
        XCTAssertTrue(orderedDictionary[1] == ("B", 2))
        
        XCTAssertEqual(orderedDictionary["C"], 3)
        XCTAssertEqual(orderedDictionary.value(forKey: "C"), 3)
        XCTAssertEqual(orderedDictionary.indexForKey("C"), 2)
        XCTAssertTrue(orderedDictionary.contains(key: "C"))
        XCTAssertTrue(orderedDictionary[2] == ("C", 3))
    }
    
    func testIterator() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        var iterator = orderedDictionary.makeIterator()
        
        let indexes = [0, 1, 2]
        var indexesIterator = indexes.makeIterator()
        
        while let (actualKey, actualValue) = iterator.next() {
            let index = indexesIterator.next()
            let (expectedKey, expectedValue) = orderedDictionary[index!]
            
            XCTAssertEqual(expectedKey, actualKey)
            XCTAssertEqual(expectedValue, actualValue)
        }
        
        XCTAssertNil(iterator.next())
        XCTAssertNil(indexesIterator.next())
    }
    
    func testOrderedKeys() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        let expected = ["A", "B", "C"]
        let actual = orderedDictionary.orderedKeys
        
        XCTAssertEqual(expected, actual)
    }
    
    func testOrderedValues() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        let expected = [1, 2, 3]
        let actual = orderedDictionary.orderedValues
        
        XCTAssertEqual(expected, actual)
    }
    
    // ======================================================= //
    // MARK: - Content Modifications
    // ======================================================= //
    
    func testKeyBasedModifications() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        orderedDictionary["A"] = 5
        orderedDictionary["D"] = 10
        orderedDictionary["B"] = nil
        
        XCTAssertEqual(orderedDictionary.count, 3)
        
        XCTAssertEqual(orderedDictionary["A"], 5)
        XCTAssertEqual(orderedDictionary.indexForKey("A"), 0)
        XCTAssertTrue(orderedDictionary.contains(key: "A"))
        
        XCTAssertNil(orderedDictionary["B"])
        XCTAssertNil(orderedDictionary.indexForKey("B"))
        XCTAssertFalse(orderedDictionary.contains(key: "B"))
        
        XCTAssertEqual(orderedDictionary["C"], 3)
        XCTAssertEqual(orderedDictionary.indexForKey("C"), 1)
        XCTAssertTrue(orderedDictionary.contains(key: "C"))
        
        XCTAssertEqual(orderedDictionary["D"], 10)
        XCTAssertEqual(orderedDictionary.indexForKey("D"), 2)
        XCTAssertTrue(orderedDictionary.contains(key: "D"))
    }
    
    func testIndexBasedModifications() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        orderedDictionary[0] = ("F", 10)
        orderedDictionary[1] = ("B", 5)
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertTrue(orderedDictionary[0] == ("F", 10))
        XCTAssertTrue(orderedDictionary[1] == ("B", 5))
        XCTAssertTrue(orderedDictionary[2] == ("C", 3))
    }
    
    func testRetrievingElementAtNonExistentIndex() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        XCTAssertNil(orderedDictionary.elementAtIndex(42))
    }
    
    func testIndexBasedInsertionsOfElementsWithDistinctKeys() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        orderedDictionary.insertElement(("T", 15), atIndex: 0)
        orderedDictionary.insertElement(("U", 16), atIndex: 2)
        orderedDictionary.insertElement(("V", 17), atIndex: 5)
        orderedDictionary.insertElement(("W", 18), atIndex: 2)
        
        let expected: OrderedDictionary<String, Int> = ["T": 15, "A": 1, "W": 18, "U": 16, "B": 2, "C": 3, "V": 17]
        let actual = orderedDictionary
        
        XCTAssertTrue(expected == actual)
    }
    
    func testIndexBasedInsertionOfElementWithSameKeyBeforeItsCurrentIndex() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let previousValue = orderedDictionary.insertElement(("B", 5), atIndex: 0)
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertEqual(previousValue, 2)
        
        let expected: OrderedDictionary<String, Int> = ["B": 5, "A": 1, "C": 3]
        let actual = orderedDictionary
        
        XCTAssertTrue(expected == actual)
    }
    
    func testIndexBasedInsertionOfElementWithSameKeyAtItsCurrentIndex() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let previousValue = orderedDictionary.insertElement(("B", 5), atIndex: 1)
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertEqual(previousValue, 2)
        
        let expected: OrderedDictionary<String, Int> = ["A": 1, "B": 5, "C": 3]
        let actual = orderedDictionary
        
        XCTAssertTrue(expected == actual)
    }
    
    func testIndexBasedInsertionOfElementWithSameKeyAfterItsCurrentIndex() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let previousValue = orderedDictionary.insertElement(("B", 5), atIndex: 3)
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertEqual(previousValue, 2)
        
        let expected: OrderedDictionary<String, Int> = ["A": 1, "C": 3, "B": 5]
        let actual = orderedDictionary
        
        XCTAssertTrue(expected == actual)
    }
    
    // ======================================================= //
    // MARK: - Content Removal
    // ======================================================= //
    
    func testRemoveAll() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        orderedDictionary.removeAll()
        
        XCTAssertEqual(orderedDictionary.count, 0)
    }
    
    func testKeyBasedRemoval() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
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
    
    func testIndexBasedRemoval() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3, "D": 4]
        
        let (expectedKey1, expectedValue1) = ("A", 1)
        let (actualKey1, actualValue1) = orderedDictionary.removeAtIndex(0)!
        
        XCTAssertEqual(expectedKey1, actualKey1)
        XCTAssertEqual(expectedValue1, actualValue1)
        
        let (expectedKey2, expectedValue2) = ("D", 4)
        let (actualKey2, actualValue2) = orderedDictionary.removeAtIndex(2)!
        
        XCTAssertEqual(expectedKey2, actualKey2)
        XCTAssertEqual(expectedValue2, actualValue2)
        
        let nonExistentElement = orderedDictionary.removeAtIndex(42)
        
        XCTAssertNil(nonExistentElement)
        
        let expected: OrderedDictionary<String, Int> = ["B": 2, "C": 3]
        let actual = orderedDictionary
        
        XCTAssertTrue(expected == actual)
    }
    
    // ======================================================= //
    // MARK: - Sorting
    // ======================================================= //
    
    private let areInIncreasingOrder: (OrderedDictionary<String, Int>.Element, OrderedDictionary<String, Int>.Element) -> Bool = { element1, element2 in
        if element1.value == element2.value {
            return element1.key < element2.key
        } else {
            return element1.value < element2.value
        }
    }
    
    func testSortingWithMutation() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["E": 4, "G": 3, "A": 3, "D": 1, "B": 4]
        orderedDictionary.sort(by: areInIncreasingOrder)
        let actual = orderedDictionary
        
        let expected: OrderedDictionary<String, Int> = ["D": 1, "A": 3, "G": 3, "B": 4, "E": 4]
        
        XCTAssertTrue(actual == expected)
    }
    
    func testSortingWithoutMutation() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["E": 4, "G": 3, "A": 3, "D": 1, "B": 4]
        let actual = orderedDictionary.sorted(by: areInIncreasingOrder)
        
        let expected: OrderedDictionary<String, Int> = ["D": 1, "A": 3, "G": 3, "B": 4, "E": 4]
        
        XCTAssertTrue(actual.elementsEqual(expected, by: ==))
    }

}
