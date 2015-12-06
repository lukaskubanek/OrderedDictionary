import OrderedDictionary

////
// Initialize an ordered dictionary using an array of key-value pairs
////

var orderedDictionary: OrderedDictionary<String, Int> = [
    ("A", 1),
    ("B", 2),
    ("C", 3),
    ("D", 4)
]

print(orderedDictionary) // => [A: 1, B: 2, C: 3, D: 4]

////
// Loop through the contents
////

for (index, (key, value)) in orderedDictionary.enumerate() {
    print("\(index): (\(key): \(value))")
}

// => 0: (A: 1)
// => 1: (B: 2)
// => 2: (C: 3)
// => 3: (D: 4)

////
// Modify the values by setting the value for key
////

orderedDictionary["A"] = 100
orderedDictionary["E"] = 5
orderedDictionary["B"] = nil
orderedDictionary.updateValue(42, forKey: "D")

print(orderedDictionary) // => [A: 100, C: 3, D: 42, E: 5]

print(orderedDictionary["A"]) // => Optional(100)
print(orderedDictionary["B"]) // => nil
print(orderedDictionary["C"]) // => Optional(3)
print(orderedDictionary["D"]) // => Optional(42)
print(orderedDictionary["E"]) // => Optional(5)

////
// Modify the values by setting the element for index
////

orderedDictionary[2] = ("F", 235)
orderedDictionary.updateElement(("K", 12), atIndex: 1)
orderedDictionary.removeAtIndex(0)

print(orderedDictionary) // => [K: 12, F: 235, E: 5]

print(orderedDictionary[0]) // => ("K", 12)
print(orderedDictionary[1]) // => ("F", 235)
print(orderedDictionary[2]) // => ("E", 5)
// print(orderedDictionary[3]) // => fatal error

print(orderedDictionary.indexForKey("K")) // => Optional(0)
print(orderedDictionary.indexForKey("F")) // => Optional(1)
print(orderedDictionary.indexForKey("E")) // => Optional(2)
print(orderedDictionary.indexForKey("A")) // => nil
print(orderedDictionary.indexForKey("C")) // => nil

////
// Sorting
////

var sortingOrderedDictionary: OrderedDictionary<String, Int> = [
    ("E", 4),
    ("G", 3),
    ("A", 3),
    ("D", 1),
    ("B", 4)
]

sortingOrderedDictionary.sortInPlace { (item1, item2) in
    if item1.1 == item2.1 {
        return item1.0 < item2.0
    } else {
        return item1.1 < item2.1
    }
}

print(sortingOrderedDictionary) // => [D: 1, A: 3, G: 3, B: 4, E: 4]
