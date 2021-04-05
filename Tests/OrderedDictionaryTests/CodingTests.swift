import Foundation
import OrderedDictionary
import XCTest

class CodingTests: XCTestCase {
 
    func testEncodingAndDecodingViaJSON() throws {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(orderedDictionary)
        let actualString = String(data: data, encoding: .utf8)
        
        let expectedString = "[\"a\",1,\"b\",2,\"c\",3]"
        
        XCTAssertEqual(actualString, expectedString)
        
        let jsonDecoder = JSONDecoder()
        let actual = try jsonDecoder.decode(OrderedDictionary<String, Int>.self, from: data)
        
        let expected = orderedDictionary
        
        XCTAssertEqual(actual, expected)
    }
    
    func testEncodingAndDecodingViaPropertyList() throws {
        let orderedDictionary: OrderedDictionary<String, Int> = ["a": 1, "b": 2, "c": 3]
        
        let plistEncoder = PropertyListEncoder()
        let data = try plistEncoder.encode(orderedDictionary)
        
        let plistDecoder = PropertyListDecoder()
        let actual = try plistDecoder.decode(OrderedDictionary<String, Int>.self, from: data)
        
        let expected = orderedDictionary
        
        XCTAssertEqual(actual, expected)
    }
    
}
