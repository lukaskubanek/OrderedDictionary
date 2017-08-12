import Foundation
import OrderedDictionary

let orderedDictionary1: OrderedDictionary<String, Int> = [
    "A": 42,
    "B": 100,
    "C": 11
]

// ======================================================= //
// MARK: - JSON Encoding & Decoding
// ======================================================= //

let jsonEncoder = JSONEncoder()
let jsonData = try! jsonEncoder.encode(orderedDictionary1)
let jsonString = String(data: jsonData, encoding: .utf8)

let jsonDecoder = JSONDecoder()
let orderedDictionary2 = try! jsonDecoder.decode(OrderedDictionary<String, Int>.self, from: jsonData)

orderedDictionary1 == orderedDictionary2

// ======================================================= //
// MARK: - Property List Encoding & Decoding
// ======================================================= //

let plistEncoder = PropertyListEncoder()
let plistData = try! plistEncoder.encode(orderedDictionary1)

let plistDecoder = PropertyListDecoder()
let orderedDictionary3 = try! plistDecoder.decode(OrderedDictionary<String, Int>.self, from: plistData)

orderedDictionary1 == orderedDictionary3

// ======================================================= //
// MARK: - Non-codable Type
// ======================================================= //

struct NonCodableType {
    var string: String
}

let orderedDictionary4: OrderedDictionary<String, NonCodableType> = [
    "A" : NonCodableType(string: "Foo"),
    "B" : NonCodableType(string: "Bar"),
    "C" : NonCodableType(string: "Baz")
]

//try? jsonEncoder.encode(x)
