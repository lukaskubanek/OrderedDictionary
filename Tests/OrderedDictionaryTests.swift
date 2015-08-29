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
    
    func testInitialization() {
        expect(self.orderedDictionary.count) == 3
        
        expect(self.orderedDictionary["A"]) == 1
        expect(self.orderedDictionary.indexForKey("A")) == 0
        
        expect(self.orderedDictionary["B"]) == 2
        expect(self.orderedDictionary.indexForKey("B")) == 1
        
        expect(self.orderedDictionary["C"]) == 3
        expect(self.orderedDictionary.indexForKey("C")) == 2
    }
    
    func testRemoveAll() {
        self.orderedDictionary.removeAll()
        
        expect(self.orderedDictionary.count) == 0
    }
    
    func testRemovalForKey() {
        self.orderedDictionary.removeValueForKey("A")
        self.orderedDictionary.removeValueForKey("K")
        
        expect(self.orderedDictionary.count) == 2
        
        expect(self.orderedDictionary["A"]).to(beNil())
        expect(self.orderedDictionary.indexForKey("A")).to(beNil())
        
        expect(self.orderedDictionary["B"]) == 2
        expect(self.orderedDictionary.indexForKey("B")) == 0
        
        expect(self.orderedDictionary["C"]) == 3
        expect(self.orderedDictionary.indexForKey("C")) == 1

    }
    
    func testGenerator() {
        for entry in self.orderedDictionary.enumerate() {
            expect(self.orderedDictionary[entry.index].0) == entry.element.0
            expect(self.orderedDictionary[entry.index].1) == entry.element.1
        }
    }
    
    func testKeyBasedSubscript() {
        self.orderedDictionary["A"] = 5
        self.orderedDictionary["D"] = 10
        self.orderedDictionary["B"] = nil
        
        expect(self.orderedDictionary.count) == 3
        
        expect(self.orderedDictionary["A"]) == 5
        expect(self.orderedDictionary.indexForKey("A")) == 0
        
        expect(self.orderedDictionary["B"]).to(beNil())
        expect(self.orderedDictionary.indexForKey("B")).to(beNil())
        
        expect(self.orderedDictionary["C"]) == 3
        expect(self.orderedDictionary.indexForKey("C")) == 1
        
        expect(self.orderedDictionary["D"]) == 10
        expect(self.orderedDictionary.indexForKey("D")) == 2
    }
    
    func testDescription() {
        expect(self.orderedDictionary.description) == "[A: 1, B: 2, C: 3]"
    }
    
}
