import Foundation
import OrderedDictionary
import XCTest

func sortByValuesAndKeys<Key: Comparable, Value: Comparable>(
    element1: (key: Key, value: Value),
    element2: (key: Key, value: Value)
) -> Bool {
    if element1.value != element2.value {
        return element1.value < element2.value
    } else {
        return element1.key < element2.key
    }
}

class SortingTests: XCTestCase {
    
    // ============================================================================ //
    // MARK: - Mutating Sort
    // ============================================================================ //
    
    func testMutatingSort() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["e": 4, "g": 3, "a": 3, "d": 1, "b": 4]
        
        orderedDictionary.sort(by: sortByValuesAndKeys)
        
        XCTAssertEqual(
            orderedDictionary,
            ["d": 1, "a": 3, "g": 3, "b": 4, "e": 4]
        )
    }
    
    func testMutatingSort_throughSlice() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["e": 4, "g": 3, "a": 3, "d": 1, "b": 4]
        
        orderedDictionary[2..<5].sort(by: sortByValuesAndKeys)
        
        XCTAssertEqual(
            orderedDictionary,
            ["e": 4, "g": 3, "d": 1, "a": 3, "b": 4]
        )
    }
    
    // ============================================================================ //
    // MARK: - Non-mutating Sort
    // ============================================================================ //
    
    func testSortingWithoutMutation() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["e": 4, "g": 3, "a": 3, "d": 1, "b": 4]
        
        XCTAssertEqual(
            orderedDictionary.sorted(by: sortByValuesAndKeys),
            ["d": 1, "a": 3, "g": 3, "b": 4, "e": 4]
        )
    }
    
    // ============================================================================ //
    // MARK: - Sorting Unsorted Dictionary
    // ============================================================================ //
    
    func testSortingUnsortedDictionary() {
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
