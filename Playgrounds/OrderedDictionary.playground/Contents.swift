// Import the framework
import OrderedDictionary

// ======================================================= //
// CONSTRUCTION
// ======================================================= //

// Construct an ordered dictionary using a dictionary literal
var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3, "D": 4]
print(orderedDictionary) // => [A: 1, B: 2, C: 3, D: 4]

// ======================================================= //
// LOOPING
// ======================================================= //

// Loop through the ordered dictionary
for (key, value) in orderedDictionary {
    print("[\(key): \(value)]") // => [A: 1], => [B: 2], => [C: 3], => [D: 4]
}

// Loop through the ordered dictionary with an additional index
for (index, (key, value)) in orderedDictionary.enumerate() {
    print("(\(index): [\(key): \(value)])") // => (0: [A: 1]), => (1: [B: 2]), => (2: [C: 3]), => (3: [D: 4])
}

// ======================================================= //
// ACCESSING CONTENT
// ======================================================= //

// Access the value for an existing key using subscript
print(orderedDictionary["A"]) // => Optional(1)

// Access the value for a non-existent key
print(orderedDictionary["X"]) // => nil

// Access the value for a key using method
print(orderedDictionary.valueForKey("A")) // => Optional(1)

// Access the value for a non-existent key
print(orderedDictionary.valueForKey("X")) // => nil

// Access the key-value pair (element) at an existing index
print(orderedDictionary[2]) // => ("C", 3)

// Access the key-value pair (element) at a non-existent index
//print(orderedDictionary[10]) // => fatal error

// Get the index for an existing key
print(orderedDictionary.indexForKey("D")) // => Optional(3)

// ======================================================= //
// MODIFYING CONTENT USING KEYS
// ======================================================= //

// Modify the value for an existing key using subscript
orderedDictionary["A"] = 100
print(orderedDictionary["A"]) // => Optional(100)

// Modify the value for an existing key using method
orderedDictionary.updateValue(42, forKey: "D")
print(orderedDictionary["D"]) // => Optional(42)

// Set a value for an non-existent key
orderedDictionary["E"] = 5
print(orderedDictionary) // => [A: 100, B: 2, C: 3, D: 42, E: 5]

// Set nil value for an existing key
orderedDictionary["B"] = nil
print(orderedDictionary["B"]) // => nil
print(orderedDictionary) // => [A: 100, C: 3, D: 42, E: 5]

// ======================================================= //
// MODIFYING CONTENT USING INDEXES
// ======================================================= //

// Modify the existing element at index using subscript
orderedDictionary[2] = ("F", 235)
print(orderedDictionary[2]) // => ("F", 235)
print(orderedDictionary) // => [A: 100, C: 3, F: 235, E: 5]

// Modify the existing element at index using method
let previousElement = orderedDictionary.updateElement(("K", 12), atIndex: 1)
print(orderedDictionary[1]) // => ("K", 12)
print(previousElement) // => Optional("C", 3)
print(orderedDictionary) // => [A: 100, K: 12, F: 235, E: 5]

// Set an element to a non-existent index
//orderedDictionary[100] = ("L", 0) // => fatal error

// ======================================================= //
// SORTING
// ======================================================= //

// Sort the ordered dictionary using a closure
orderedDictionary.sortInPlace { (element1: (key: String, value: Int), element2: (key: String, value: Int)) -> Bool in
    if element1.value == element2.value {
        return element1.key < element2.key
    } else {
        return element1.value < element2.value
    }
}
print(orderedDictionary) // => [E: 5, K: 12, A: 100, F: 235]

// ======================================================= //
// REMOVING CONTENT
// ======================================================= //

// Remove value for an existing key
let removedValue = orderedDictionary.removeValueForKey("F")
print(removedValue) // => Optional(235)
print(orderedDictionary["F"]) // => nil
print(orderedDictionary) // => [E: 5, K: 12, A: 100]

// Remove value for a non-existent key
orderedDictionary.removeValueForKey("X")
print(orderedDictionary) // => [E: 5, K: 12, A: 100]

// Remove element at an existing index
let removedElement = orderedDictionary.removeAtIndex(1)
print(removedElement) // => Optional((K, 12))
print(orderedDictionary) // => [E: 5, A: 100]

// Remove element at a non-existent index
orderedDictionary.removeAtIndex(42)
print(orderedDictionary) // => [E: 5, A: 100]

// Remove all elements
orderedDictionary.removeAll()
print(orderedDictionary) // => [:]
