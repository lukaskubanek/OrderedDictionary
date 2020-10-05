import Foundation
import OrderedDictionary
import XCTest

class SortingTests: XCTestCase {
    
    func testSortingWithMutation() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["e": 4, "g": 3, "a": 3, "d": 1, "b": 4]
        
        orderedDictionary.sort { element1, element2 in
            if element1.value != element2.value {
                return element1.value < element2.value
            } else {
                return element1.key < element2.key
            }
        }
        
        let actual = orderedDictionary
        let expected: OrderedDictionary<String, Int> = ["d": 1, "a": 3, "g": 3, "b": 4, "e": 4]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testSortingWithoutMutation() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["e": 4, "g": 3, "a": 3, "d": 1, "b": 4]
        
        let actual = orderedDictionary.sorted { element1, element2 in
            if element1.value != element2.value {
                return element1.value < element2.value
            } else {
                return element1.key < element2.key
            }
        }
        
        let expected: OrderedDictionary<String, Int> = ["d": 1, "a": 3, "g": 3, "b": 4, "e": 4]
        
        XCTAssertEqual(actual, expected)
    }
 
    func testSortingAnUnsortedDictionary() {
        let dictionary = [
            2: "foo",
            1: "bar",
            4: "baz",
            5: "bat",
            3: "bam"
        ]
        
        let actual = dictionary.sorted { $0.key < $1.key }
        
        let expected: OrderedDictionary<Int, String> = [
            1: "bar",
            2: "foo",
            3: "bam",
            4: "baz",
            5: "bat"
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
}
