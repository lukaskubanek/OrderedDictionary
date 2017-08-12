import OrderedDictionary
import Foundation
import XCTest

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
        let expected = OrderedDictionary<String, Int>([
            (key: "A", value: 1),
            (key: "B", value: 2),
            (key: "C", value: 3)
        ])
        let actual: OrderedDictionary<String, Int> = [("A", 1), ("B", 2), ("C", 3)]
        
        XCTAssertTrue(expected == actual)
    }
    
    func testInitializationUsingDictionaryLiteral() {
        let expected = OrderedDictionary<String, Int>([
            (key: "A", value: 1),
            (key: "B", value: 2),
            (key: "C", value: 3)
        ])
        let actual: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        XCTAssertTrue(expected == actual)
    }
    
    func testInitializationUsingValuesAndKeyProviderClosure() {
        let values = [1, 2, 3]
        
        let expected = OrderedDictionary<String, Int>([
            (key: "1", value: 1),
            (key: "2", value: 2),
            (key: "3", value: 3)
        ])
        let actual = OrderedDictionary(values: values, keyedBy: { "\($0)" })
        
        XCTAssertTrue(expected == actual)
    }
    
    func testInitializationUsingValuesAnyKeyPath() {
        let values = [
            TestValue(string: "A"),
            TestValue(string: "B"),
            TestValue(string: "C")
        ]
        
        let expected = OrderedDictionary<String, TestValue>([
            (key: "A", value: TestValue(string: "A")),
            (key: "B", value: TestValue(string: "B")),
            (key: "C", value: TestValue(string: "C"))
        ])
        let actual = OrderedDictionary(values: values, keyedBy: \.string)

        XCTAssertTrue(expected == actual)
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
            
            XCTAssertEqual(expectedKey, actualKey)
            XCTAssertEqual(expectedValue, actualValue)
        }
        
        XCTAssertNil(iterator.next())
        XCTAssertNil(indexesIterator.next())
    }
    
    func testAccessingOrderedKeys() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        let expected = ["A", "B", "C"]
        let actual = Array(orderedDictionary.orderedKeys)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAccessingOrderedValues() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        let expected = [1, 2, 3]
        let actual = Array(orderedDictionary.orderedValues)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAccessingUnsortedDictionary() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        
        let expected = ["A": 1, "B": 2, "C": 3]
        let actual = orderedDictionary.unorderedDictionary
        
        XCTAssertEqual(expected, actual)
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
        
        let expected: OrderedDictionary<String, Int> = ["T": 15, "A": 1, "W": 18, "U": 16, "B": 2, "C": 3, "V": 17]
        let actual = orderedDictionary
        
        XCTAssertTrue(expected == actual)
    }
    
    func testIndexBasedInsertionWithDuplicateKey() {
        let orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let invalidElement = (key: "A", value: 42)
        
        XCTAssertFalse(orderedDictionary.canInsert(invalidElement))
    }
    
    // ======================================================= //
    // MARK: - Index-based Updates
    // ======================================================= //
    
    func testIndexBasedUpdateMethodWithNewUniqueKey() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let previousElement = orderedDictionary.update((key: "D", value: 4), at: 1)
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertTrue(previousElement! == ("B", 2))
        
        let expected: OrderedDictionary<String, Int> = ["A": 1, "D": 4, "C": 3]
        let actual = orderedDictionary
        
        XCTAssertTrue(expected == actual)
    }
    
    func testIndexBasedUpdateMethodByReplacingSameKey() {
        var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3]
        let previousElement = orderedDictionary.update((key: "B", value: 42), at: 1)
        
        XCTAssertEqual(orderedDictionary.count, 3)
        XCTAssertTrue(previousElement! == ("B", 2))
        
        let expected: OrderedDictionary<String, Int> = ["A": 1, "B": 42, "C": 3]
        let actual = orderedDictionary
        
        XCTAssertTrue(expected == actual)
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
        
        let (expectedKey1, expectedValue1) = ("A", 1)
        let (actualKey1, actualValue1) = orderedDictionary.remove(at: 0)!
        
        XCTAssertEqual(expectedKey1, actualKey1)
        XCTAssertEqual(expectedValue1, actualValue1)
        
        let (expectedKey2, expectedValue2) = ("D", 4)
        let (actualKey2, actualValue2) = orderedDictionary.remove(at: 2)!
        
        XCTAssertEqual(expectedKey2, actualKey2)
        XCTAssertEqual(expectedValue2, actualValue2)
        
        let nonExistentElement = orderedDictionary.remove(at: 42)
        
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
        let actual: OrderedDictionary<String, Int> = orderedDictionary.sorted(by: areInIncreasingOrder)
        
        let expected: OrderedDictionary<String, Int> = ["D": 1, "A": 3, "G": 3, "B": 4, "E": 4]
        
        XCTAssertTrue(actual.elementsEqual(expected, by: ==))
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
        
        let expectedString = "[\"A\",42,\"B\",100,\"C\",11]"
        let actualString = String(data: data, encoding: .utf8)
        
        XCTAssertEqual(expectedString, actualString)
        
        let jsonDecoder = JSONDecoder()
        
        let expectedOrderedDictionary = orderedDictionary
        let actualOrderedDictionary = try! jsonDecoder.decode(OrderedDictionary<String, Int>.self, from: data)
        
        XCTAssertTrue(expectedOrderedDictionary == actualOrderedDictionary)
    }
    
    func testEncodingAndDecodingViaPropertyList() {
        let orderedDictionary: OrderedDictionary<String, Int> = [
            "A": 42,
            "B": 100,
            "C": 11
        ]
        
        let plistEncoder = PropertyListEncoder()
        let plistDecoder = PropertyListDecoder()
        
        let data = try! plistEncoder.encode(orderedDictionary)
        
        let expectedOrderedDictionary = orderedDictionary
        let actualOrderedDictionary = try! plistDecoder.decode(OrderedDictionary<String, Int>.self, from: data)
        
        XCTAssertTrue(expectedOrderedDictionary == actualOrderedDictionary)
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

}
