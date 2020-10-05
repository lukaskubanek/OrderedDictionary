import Foundation
import OrderedDictionary
import XCTest

class InitializationTests: XCTestCase {
    
    func testInitializationFromArrayLiteral() {
        let actual: OrderedDictionary = [
            ("a", 1),
            ("b", 2),
            ("c", 3)
        ]
        
        let expected = OrderedDictionary(uniqueKeysWithValues: [
            (key: "a", value: 1),
            (key: "b", value: 2),
            (key: "c", value: 3)
        ])
        
        XCTAssertEqual(actual, expected)
    }
    
    func testInitializationFromDictionaryLiteral() {
        let actual: OrderedDictionary = [
            "a": 1,
            "b": 2,
            "c": 3
        ]
        
        let expected = OrderedDictionary(uniqueKeysWithValues: [
            (key: "a", value: 1),
            (key: "b", value: 2),
            (key: "c", value: 3)
        ])
        
        XCTAssertEqual(actual, expected)
    }
    
    func testInitializationFromValuesAndKeyProviderClosure() {
        let actual = OrderedDictionary(
            values: [1, 2, 3],
            uniquelyKeyedBy: { String($0) }
        )
        
        let expected = OrderedDictionary(uniqueKeysWithValues: [
            (key: "1", value: 1),
            (key: "2", value: 2),
            (key: "3", value: 3)
        ])
        
        XCTAssertEqual(actual, expected)
    }
    
    func testInitializationFromValuesAndKeyPath() {
        let actual = OrderedDictionary(
            values: ["a", "b", "c"],
            uniquelyKeyedBy: \.self
        )
        
        let expected = OrderedDictionary(uniqueKeysWithValues: [
            (key: "a", value: "a"),
            (key: "b", value: "b"),
            (key: "c", value: "c")
        ])

        XCTAssertEqual(actual, expected)
    }
    
    func testInitializationFromUnsortedDictionaryAndSortFunction() {
        let actual = OrderedDictionary(
            unsorted: [
                2: "foo",
                1: "bar",
                4: "baz",
                5: "bat",
                3: "bam"
            ],
            areInIncreasingOrder: { $0.key < $1.key }
        )
        
        let expected = OrderedDictionary(uniqueKeysWithValues: [
            (key: 1, value: "bar"),
            (key: 2, value: "foo"),
            (key: 3, value: "bam"),
            (key: 4, value: "baz"),
            (key: 5, value: "bat")
        ])
        
        XCTAssertEqual(actual, expected)
    }
    
}
