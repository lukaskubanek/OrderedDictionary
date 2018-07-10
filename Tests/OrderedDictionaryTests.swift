import OrderedDictionary
import Foundation
import XCTest

#if !swift(>=4.1)

/// This is a shim for testing the equality in Swift <4.1.
public func XCTAssertEqual<K, V: Equatable>(
    _ expression1: OrderedDictionary<K, V>,
    _ expression2: OrderedDictionary<K, V>,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    return XCTAssertTrue(
        expression1 == expression2,
        message,
        file: file,
        line: line
    )
}

#endif

struct TestValue: Equatable {
    var string: String
    static func == (lhs: TestValue, rhs: TestValue) -> Bool {
        return lhs.string == rhs.string
    }
}

class OrderedDictionaryTests: XCTestCase {
    
    // ======================================================= //
    // MARK: - Initialization
    // ======================================================= //
    
    func testInitializationUsingArrayLiteral() {
        let actual: OrderedDictionary<String, Int> = [
            ("A", 1),
            ("B", 2),
            ("C", 3)
        ]
        
        let expected = OrderedDictionary<String, Int>([
            (key: "A", value: 1),
            (key: "B", value: 2),
            (key: "C", value: 3)
        ])
        
        XCTAssertEqual(actual, expected)
    }
    
    func testInitializationUsingDictionaryLiteral() {
        let actual: OrderedDictionary<String, Int> = [
            "A": 1,
            "B": 2,
            "C": 3
        ]
        
        let expected = OrderedDictionary<String, Int>([
            (key: "A", value: 1),
            (key: "B", value: 2),
            (key: "C", value: 3)
        ])
        
        XCTAssertEqual(actual, expected)
    }
    
    func testInitializationUsingValuesAndKeyProviderClosure() {
        let actual = OrderedDictionary(
            values: [1, 2, 3],
            keyedBy: { "\($0)" }
        )
        
        let expected = OrderedDictionary<String, Int>([
            (key: "1", value: 1),
            (key: "2", value: 2),
            (key: "3", value: 3)
        ])
        
        XCTAssertEqual(actual, expected)
    }
    
    func testInitializationUsingValuesAnyKeyPath() {
        let actual = OrderedDictionary(
            values: [
                TestValue(string: "A"),
                TestValue(string: "B"),
                TestValue(string: "C")
            ],
            keyedBy: \.string
        )
        
        let expected = OrderedDictionary<String, TestValue>([
            (key: "A", value: TestValue(string: "A")),
            (key: "B", value: TestValue(string: "B")),
            (key: "C", value: TestValue(string: "C"))
        ])

        XCTAssertEqual(actual, expected)
    }
    
    func testInitializationUsingUnsortedDictionaryAndSortFunction() {
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
        
        let expected = OrderedDictionary([
            (key: 1, value: "bar"),
            (key: 2, value: "foo"),
            (key: 3, value: "bam"),
            (key: 4, value: "baz"),
            (key: 5, value: "bat")
        ])
        
        XCTAssertEqual(actual, expected)
    }
    
    func testCreationFromDictionary() {
        let actual = [
            2: "foo",
            1: "bar",
            4: "baz",
            5: "bat",
            3: "bam"
        ].sorted(by: { $0.key < $1.key })
        
        let expected = OrderedDictionary([
            (key: 1, value: "bar"),
            (key: 2, value: "foo"),
            (key: 3, value: "bam"),
            (key: 4, value: "baz"),
            (key: 5, value: "bat")
        ])
        
        XCTAssertEqual(actual, expected)
    }
    
    // ======================================================= //
    // MARK: - Content Access
    // ======================================================= //
    
    func testAccessingContent() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        XCTAssertEqual(orderedDictionary.count, 3)
        
        XCTAssertEqual(orderedDictionary["A"], 1)
        XCTAssertEqual(orderedDictionary.value(forKey: "A"), 1)
        XCTAssertEqual(orderedDictionary.index(forKey: "A"), 0)
        XCTAssertTrue(orderedDictionary.containsKey("A"))
        XCTAssertTrue(orderedDictionary[0] == ("A", 1))
        
        XCTAssertEqual(orderedDictionary["B"], 2)
        XCTAssertEqual(orderedDictionary.value(forKey: "B"), 2)
        XCTAssertEqual(orderedDictionary.index(forKey: "B"), 1)
        XCTAssertTrue(orderedDictionary.containsKey("B"))
        XCTAssertTrue(orderedDictionary[1] == ("B", 2))
        
        XCTAssertEqual(orderedDictionary["C"], 3)
        XCTAssertEqual(orderedDictionary.value(forKey: "C"), 3)
        XCTAssertEqual(orderedDictionary.index(forKey: "C"), 2)
        XCTAssertTrue(orderedDictionary.containsKey("C"))
        XCTAssertTrue(orderedDictionary[2] == ("C", 3))
    }
    
    func testCreatingIterator() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        var iterator = orderedDictionary.makeIterator()
        
        let indexes = [0, 1, 2]
        var indexesIterator = indexes.makeIterator()
        
        while let (actualKey, actualValue) = iterator.next() {
            let index = indexesIterator.next()
            let (expectedKey, expectedValue) = orderedDictionary[index!]
            
            XCTAssertEqual(actualKey, expectedKey)
            XCTAssertEqual(actualValue, expectedValue)
        }
        
        XCTAssertNil(iterator.next())
        XCTAssertNil(indexesIterator.next())
    }
    
    func testAccessingOrderedKeys() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let actual = Array(orderedDictionary.orderedKeys)
        
        let expected = ["A", "B", "C"]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testAccessingOrderedValues() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let actual = Array(orderedDictionary.orderedValues)
        
        let expected = [1, 2, 3]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testAccessingUnsortedDictionary() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let actual = orderedDictionary.unorderedDictionary
        
        let expected = ["A": 1, "B": 2, "C": 3]
        
        XCTAssertEqual(actual, expected)
    }
    
    // ======================================================= //
    // MARK: - Key-based Modifications
    // ======================================================= //
    
    func testKeyBasedModifications() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        orderedDictionary["A"] = 5
        orderedDictionary["D"] = 10
        orderedDictionary["B"] = nil
        
        XCTAssertEqual(orderedDictionary.count, 3)
        
        XCTAssertEqual(orderedDictionary["A"], 5)
        XCTAssertEqual(orderedDictionary.index(forKey: "A"), 0)
        XCTAssertTrue(orderedDictionary.containsKey("A"))
        
        XCTAssertNil(orderedDictionary["B"])
        XCTAssertNil(orderedDictionary.index(forKey: "B"))
        XCTAssertFalse(orderedDictionary.containsKey("B"))
        
        XCTAssertEqual(orderedDictionary["C"], 3)
        XCTAssertEqual(orderedDictionary.index(forKey: "C"), 1)
        XCTAssertTrue(orderedDictionary.containsKey("C"))
        
        XCTAssertEqual(orderedDictionary["D"], 10)
        XCTAssertEqual(orderedDictionary.index(forKey: "D"), 2)
        XCTAssertTrue(orderedDictionary.containsKey("D"))
    }
    
    // ======================================================= //
    // MARK: - Index-based Insertions
    // ======================================================= //
    
    func testIndexBasedInsertionsWithUniqueKeys() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        orderedDictionary.insert((key: "T", value: 15), at: 0)
        orderedDictionary.insert((key: "U", value: 16), at: 2)
        orderedDictionary.insert((key: "V", value: 17), at: 5)
        orderedDictionary.insert((key: "W", value: 18), at: 2)
        let actual = orderedDictionary
        
        let expected: OrderedDictionary<String, Int> = ["T": 15, "A": 1, "W": 18, "U": 16, "B": 2, "C": 3, "V": 17]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testIndexBasedInsertionWithDuplicateKey() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let invalidKey = "A"
        
        XCTAssertFalse(orderedDictionary.canInsert(key: invalidKey))
    }
    
    func testIndexBasedInsertionWithNegativeIndex() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let invalidIndex = -1
        
        XCTAssertFalse(orderedDictionary.canInsert(at: invalidIndex))
    }
    
    func testIndexBasedInsertionWithIndexOutOfBounds() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let invalidIndex = 4
        
        XCTAssertFalse(orderedDictionary.canInsert(at: invalidIndex))
    }
    
    // ======================================================= //
    // MARK: - Index-based Updates
    // ======================================================= //
    
    func testIndexBasedUpdateMethodWithNewUniqueKey() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let previousElement = orderedDictionary.update((key: "D", value: 4), at: 1)
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertTrue(previousElement! == ("B", 2))
        
        let actual = orderedDictionary
        let expected: OrderedDictionary<String, Int> = ["A": 1, "D": 4, "C": 3]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testIndexBasedUpdateMethodByReplacingSameKey() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let previousElement = orderedDictionary.update((key: "B", value: 42), at: 1)
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertTrue(previousElement! == ("B", 2))
        
        let actual = orderedDictionary
        let expected: OrderedDictionary<String, Int> = ["A": 1, "B": 42, "C": 3]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testIndexBasedUpdateMethodByDuplicatingKey() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        let element = (key: "A", value: 42)
        
        XCTAssertTrue(orderedDictionary.canUpdate(element, at: 0))
        XCTAssertFalse(orderedDictionary.canUpdate(element, at: 1))
        XCTAssertFalse(orderedDictionary.canUpdate(element, at: 2))
    }
    
    func testRetrievingElementAtNonExistentIndex() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        XCTAssertNil(orderedDictionary.elementAt(42))
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
        
        let removedValue1 = orderedDictionary.removeValue(forKey: "A")
        let removedValue2 = orderedDictionary.removeValue(forKey: "K")
        
        XCTAssertEqual(removedValue1, 1)
        XCTAssertNil(removedValue2)
        
        XCTAssertEqual(orderedDictionary.count, 2)
        
        XCTAssertNil(orderedDictionary["A"])
        XCTAssertNil(orderedDictionary.index(forKey: "A"))
        
        XCTAssertEqual(orderedDictionary["B"], 2)
        XCTAssertEqual(orderedDictionary.index(forKey: "B"), 0)
        
        XCTAssertEqual(orderedDictionary["C"], 3)
        XCTAssertEqual(orderedDictionary.index(forKey: "C"), 1)
    }
    
    func testIndexBasedRemoval() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3, "D": 4]
        
        let (actualKey1, actualValue1) = orderedDictionary.remove(at: 0)!
        let (expectedKey1, expectedValue1) = ("A", 1)
        
        XCTAssertEqual(actualKey1, expectedKey1)
        XCTAssertEqual(actualValue1, expectedValue1)
        
        let (actualKey2, actualValue2) = orderedDictionary.remove(at: 2)!
        let (expectedKey2, expectedValue2) = ("D", 4)
        
        XCTAssertEqual(actualKey2, expectedKey2)
        XCTAssertEqual(actualValue2, expectedValue2)
        
        let nonExistentElement = orderedDictionary.remove(at: 42)
        
        XCTAssertNil(nonExistentElement)
        
        let actual = orderedDictionary
        let expected: OrderedDictionary<String, Int> = ["B": 2, "C": 3]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testPopFirstEmpty() {
        var orderedDictionary: OrderedDictionary<String, Int> = []
        let first = orderedDictionary.popFirst()
        
        XCTAssertNil(first)
    }
    
    func testPopFirstNonEmpty() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3, "D": 4]
        
        let (actualKey, actualValue) = orderedDictionary.popFirst()!
        let (expectedKey, expectedValue) = ("A", 1)
        
        XCTAssertEqual(actualKey, expectedKey)
        XCTAssertEqual(actualValue, expectedValue)
        
        let actual = orderedDictionary
        let expected: OrderedDictionary<String, Int> = ["B": 2, "C": 3, "D": 4]

        XCTAssertEqual(actual, expected)
    }
    
    func testPopLastEmpty() {
        var orderedDictionary: OrderedDictionary<String, Int> = []
        let last = orderedDictionary.popLast()
        
        XCTAssertNil(last)
    }
    
    func testPopLastNonEmpty() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3, "D": 4]
        
        let (actualKey, actualValue) = orderedDictionary.popLast()!
        let (expectedKey, expectedValue) = ("D", 4)
        
        XCTAssertEqual(actualKey, expectedKey)
        XCTAssertEqual(actualValue, expectedValue)
        
        let actual = orderedDictionary
        let expected: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testRemoveFirstNonEmpty() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3, "D": 4]
        
        let (actualKey, actualValue) = orderedDictionary.removeFirst()
        let (expectedKey, expectedValue) = ("A", 1)
        
        XCTAssertEqual(actualKey, expectedKey)
        XCTAssertEqual(actualValue, expectedValue)
        
        let actual = orderedDictionary
        let expected: OrderedDictionary<String, Int> = ["B": 2, "C": 3, "D": 4]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testRemoveLastNonEmpty() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3, "D": 4]
        
        let (actualKey, actualValue) = orderedDictionary.removeLast()
        let (expectedKey, expectedValue) = ("D", 4)
        
        XCTAssertEqual(actualKey, expectedKey)
        XCTAssertEqual(actualValue, expectedValue)
        
        let actual = orderedDictionary
        let expected: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        XCTAssertEqual(actual, expected)
    }
    
    // ======================================================= //
    // MARK: - Moving Elements
    // ======================================================= //
    
    func testMovingElements() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3, "D": 4]
        
        XCTAssertEqual(orderedDictionary.moveElement(forKey: "A", to: 2), 0) // B, C, A, D
        XCTAssertEqual(orderedDictionary.moveElement(forKey: "D", to: 3), 3) // B, C, A, D
        XCTAssertEqual(orderedDictionary.moveElement(forKey: "C", to: 0), 1) // C, B, A, D
        XCTAssertEqual(orderedDictionary.moveElement(forKey: "B", to: 3), 1) // C, A, D, B
        XCTAssertEqual(orderedDictionary.moveElement(forKey: "E", to: 0), nil)
        
        let actual = orderedDictionary
        let expected: OrderedDictionary<String, Int> = ["C": 3, "A": 1, "D": 4, "B": 2]
        
        XCTAssertEqual(actual, expected)
    }
    
    // ======================================================= //
    // MARK: - Sorting Elements
    // ======================================================= //
    
    func testSortingWithMutation() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["E": 4, "G": 3, "A": 3, "D": 1, "B": 4]
        orderedDictionary.sort { element1, element2 in
            if element1.value != element2.value { return element1.value < element2.value }
            return element1.key < element2.key
        }
        let actual = orderedDictionary
        
        let expected: OrderedDictionary<String, Int> = ["D": 1, "A": 3, "G": 3, "B": 4, "E": 4]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testSortingWithoutMutation() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["E": 4, "G": 3, "A": 3, "D": 1, "B": 4]
        let actual: OrderedDictionary<String, Int> = orderedDictionary.sorted { element1, element2 in
            if element1.value != element2.value { return element1.value < element2.value }
            return element1.key < element2.key
        }
        
        let expected: OrderedDictionary<String, Int> = ["D": 1, "A": 3, "G": 3, "B": 4, "E": 4]
        
        XCTAssertEqual(actual, expected)
    }
    
    // ======================================================= //
    // MARK: - Slices
    // ======================================================= //
    
    func testSliceAccess() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3, "D": 4]
        let slice = orderedDictionary[2..<4]
        
        XCTAssertEqual(slice.count, 2)
        XCTAssertEqual(slice.startIndex, 2)
        XCTAssertEqual(slice.endIndex, 4)
        XCTAssertEqual(Array(slice.indices), [2, 3])
        XCTAssert(slice[2] == (key: "C", value: 3))
        XCTAssert(slice[3] == (key: "D", value: 4))
    }
    
    // ======================================================= //
    // MARK: - Codable
    // ======================================================= //
    
    func testEncodingAndDecodingViaJSON() {
        let orderedDictionary: OrderedDictionary<String, Int> = [
            "A": 42,
            "B": 100,
            "C": 11
        ]
        
        let jsonEncoder = JSONEncoder()
        let data = try! jsonEncoder.encode(orderedDictionary)
        let actualString = String(data: data, encoding: .utf8)
        
        let expectedString = "[\"A\",42,\"B\",100,\"C\",11]"
        
        XCTAssertEqual(actualString, expectedString)
        
        let jsonDecoder = JSONDecoder()
        let actual = try! jsonDecoder.decode(OrderedDictionary<String, Int>.self, from: data)
        
        let expected = orderedDictionary
        
        XCTAssertEqual(actual, expected)
    }
    
    func testEncodingAndDecodingViaPropertyList() {
        let orderedDictionary: OrderedDictionary<String, Int> = [
            "A": 42,
            "B": 100,
            "C": 11
        ]
        
        let plistEncoder = PropertyListEncoder()
        let data = try! plistEncoder.encode(orderedDictionary)
        
        let plistDecoder = PropertyListDecoder()
        let actual = try! plistDecoder.decode(OrderedDictionary<String, Int>.self, from: data)
        
        let expected = orderedDictionary
        
        XCTAssertEqual(actual, expected)
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
        let orderedDictionary = OrderedDictionary<String, DescribedValue>()
        let actual = orderedDictionary.description
        
        let expected = "[:]"
        
        XCTAssertEqual(actual, expected)
    }
    
    func testDescription() {
        let orderedDictionary: OrderedDictionary<String, DescribedValue> = [
            "A": DescribedValue(1),
            "B": DescribedValue(2),
            "C": DescribedValue(3)
        ]
        let actual = orderedDictionary.description
        
        let expected = "[A: 1, B: 2, C: 3]"
        
        XCTAssertEqual(actual, expected)
    }
    
    func testEmptyDebugDescription() {
        let orderedDictionary = OrderedDictionary<String, DescribedValue>()
        let actual = orderedDictionary.debugDescription
        
        let expected = "[:]"
        
        XCTAssertEqual(actual, expected)
    }
    
    func testDebugDescription() {
        let orderedDictionary: OrderedDictionary<String, DescribedValue> = [
            "A": DescribedValue(1),
            "B": DescribedValue(2),
            "C": DescribedValue(3)
        ]
        let actual = orderedDictionary.debugDescription
        
        let expected = "[\"A\": debug(1), \"B\": debug(2), \"C\": debug(3)]"
        
        XCTAssertEqual(actual, expected)
    }

}
