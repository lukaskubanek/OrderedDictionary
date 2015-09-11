//
//  OrderedDictionaryTests.swift
//  OrderedDictionaryTests
//
//  Created by Lukas Kubanek on 29/08/15.
//  Copyright © 2015 Lukas Kubanek. All rights reserved.
//

import XCTest
import Nimble
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
    
    // MARK: - Content
    
    func testInitializedContent() {
        expect(self.orderedDictionary.count) == 3
        
        expect(self.orderedDictionary["A"]) == 1
        expect(self.orderedDictionary.indexForKey("A")) == 0
        expect(self.orderedDictionary.containsKey("A")) == true
        
        expect(self.orderedDictionary["B"]) == 2
        expect(self.orderedDictionary.indexForKey("B")) == 1
        expect(self.orderedDictionary.containsKey("B")) == true
        
        expect(self.orderedDictionary["C"]) == 3
        expect(self.orderedDictionary.indexForKey("C")) == 2
        expect(self.orderedDictionary.containsKey("C")) == true
    }
    
    func testInitializationUsingPairs() {
        let elements = [
            ("A", 1),
            ("B", 2),
            ("C", 3)
        ]
        
        expect(OrderedDictionary(elements: elements) == self.orderedDictionary).to(beTrue())
    }
    
    func testElementsGenerator() {
        for entry in self.orderedDictionary.enumerate() {
            expect(self.orderedDictionary[entry.index].0) == entry.element.0
            expect(self.orderedDictionary[entry.index].1) == entry.element.1
        }
    }
    
    // MARK: - Key-based Modifications
    
    func testKeyBasedSubscript() {
        self.orderedDictionary["A"] = 5
        self.orderedDictionary["D"] = 10
        self.orderedDictionary["B"] = nil
        
        expect(self.orderedDictionary.count) == 3
        
        expect(self.orderedDictionary["A"]) == 5
        expect(self.orderedDictionary.indexForKey("A")) == 0
        expect(self.orderedDictionary.containsKey("A")) == true
        
        expect(self.orderedDictionary["B"]).to(beNil())
        expect(self.orderedDictionary.indexForKey("B")).to(beNil())
        expect(self.orderedDictionary.containsKey("B")) == false
        
        expect(self.orderedDictionary["C"]) == 3
        expect(self.orderedDictionary.indexForKey("C")) == 1
        expect(self.orderedDictionary.containsKey("C")) == true
        
        expect(self.orderedDictionary["D"]) == 10
        expect(self.orderedDictionary.indexForKey("D")) == 2
        expect(self.orderedDictionary.containsKey("D")) == true
    }
    
    // MARK: - Index-based Modifications
    
    func testIndexBasedSubscriptForRetrievingValues() {
        let elementAtIndex0 = self.orderedDictionary[0]
        expect(elementAtIndex0.0) == "A"
        expect(elementAtIndex0.1) == 1
        
        let elementAtIndex1 = self.orderedDictionary[1]
        expect(elementAtIndex1.0) == "B"
        expect(elementAtIndex1.1) == 2
        
        let elementAtIndex2 = self.orderedDictionary[2]
        expect(elementAtIndex2.0) == "C"
        expect(elementAtIndex2.1) == 3
    }
    
    func testIndexBasedSubscriptForSettingValues() {
        self.orderedDictionary[0] = ("F", 10)
        self.orderedDictionary[1] = ("B", 5)
        
        let elementAtIndex0 = self.orderedDictionary[0]
        expect(elementAtIndex0.0) == "F"
        expect(elementAtIndex0.1) == 10
        
        let elementAtIndex1 = self.orderedDictionary[1]
        expect(elementAtIndex1.0) == "B"
        expect(elementAtIndex1.1) == 5
        
        let elementAtIndex2 = self.orderedDictionary[2]
        expect(elementAtIndex2.0) == "C"
        expect(elementAtIndex2.1) == 3
    }
    
    func testRetrievingElementAtNonExistentIndex() {
        expect(self.orderedDictionary.elementAtIndex(10)).to(beNil())
    }
    
    func testIndexBasedInsertionsOfElementsWithDistinctKeys() {
        self.orderedDictionary.insertElement(("T", 15), atIndex: 0)
        self.orderedDictionary.insertElement(("U", 16), atIndex: 2)
        self.orderedDictionary.insertElement(("V", 17), atIndex: 5)
        self.orderedDictionary.insertElement(("W", 18), atIndex: 2)
        
        let expectedOrderedDictionary: OrderedDictionary<String, Int> = [
            ("T", 15),
            ("A", 1),
            ("W", 18),
            ("U", 16),
            ("B", 2),
            ("C", 3),
            ("V", 17)
        ]
        
        expect(self.orderedDictionary == expectedOrderedDictionary).to(beTrue())
    }
    
    func testIndexBasedInsertionOfElementWithSameKeyBeforeItsCurrentIndex() {
        let previousValue = self.orderedDictionary.insertElement(("B", 5), atIndex: 0)
        
        let expectedOrderedDictionary: OrderedDictionary<String, Int> = [
            ("B", 5),
            ("A", 1),
            ("C", 3)
        ]
        
        expect(self.orderedDictionary.count) == 3
        expect(self.orderedDictionary == expectedOrderedDictionary).to(beTrue())
        expect(previousValue) == 2
    }
    
    func testIndexBasedInsertionOfElementWithSameKeyAtItsCurrentIndex() {
        let previousValue = self.orderedDictionary.insertElement(("B", 5), atIndex: 1)
        
        let expectedOrderedDictionary: OrderedDictionary<String, Int> = [
            ("A", 1),
            ("B", 5),
            ("C", 3)
        ]
        
        expect(self.orderedDictionary.count) == 3
        expect(self.orderedDictionary == expectedOrderedDictionary).to(beTrue())
        expect(previousValue) == 2
    }
    
    func testIndexBasedInsertionOfElementWithSameKeyAfterItsCurrentIndex() {
        let previousValue = self.orderedDictionary.insertElement(("B", 5), atIndex: 3)
        
        let expectedOrderedDictionary: OrderedDictionary<String, Int> = [
            ("A", 1),
            ("C", 3),
            ("B", 5)
        ]
        
        expect(self.orderedDictionary.count) == 3
        expect(self.orderedDictionary == expectedOrderedDictionary).to(beTrue())
        expect(previousValue) == 2
    }
    
    // MARK: - Removal
    
    func testRemoveAll() {
        self.orderedDictionary.removeAll()
        
        expect(self.orderedDictionary.count) == 0
    }
    
    func testRemovalForKey() {
        let removedValue1 = self.orderedDictionary.removeValueForKey("A")
        let removedValue2 = self.orderedDictionary.removeValueForKey("K")
        
        expect(removedValue1) == 1
        expect(removedValue2).to(beNil())
        
        expect(self.orderedDictionary.count) == 2
        
        expect(self.orderedDictionary["A"]).to(beNil())
        expect(self.orderedDictionary.indexForKey("A")).to(beNil())
        
        expect(self.orderedDictionary["B"]) == 2
        expect(self.orderedDictionary.indexForKey("B")) == 0
        
        expect(self.orderedDictionary["C"]) == 3
        expect(self.orderedDictionary.indexForKey("C")) == 1

    }
    
    func testRemovalAtIndex() {
        let removedElement1 = self.orderedDictionary.removeAtIndex(1)
        let removedElement2 = self.orderedDictionary.removeAtIndex(0)
        let removedElement3 = self.orderedDictionary.removeAtIndex(5)
        
        expect(removedElement1?.0) == "B"
        expect(removedElement1?.1) == 2
        
        expect(removedElement2?.0) == "A"
        expect(removedElement2?.1) == 1
        
        expect(removedElement3).to(beNil())
        
        expect(self.orderedDictionary.count) == 1
        
        let elementAtIndex0 = self.orderedDictionary[0]
        expect(elementAtIndex0.0) == "C"
        expect(elementAtIndex0.1) == 3
    }
    
    // MARK: - Description
    
    func testDescription() {
        expect(self.orderedDictionary.description) == "[A: 1, B: 2, C: 3]"
    }
    
}
