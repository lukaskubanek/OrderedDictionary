import OrderedDictionary

// ======================================================= //
// Helpers
// ======================================================= //

func print(_ optional: Any?) {
    print(optional as Any)
}

// ======================================================= //
// Construction
// ======================================================= //

// Construct an ordered dictionary using a dictionary literal
var orderedDictionary: OrderedDictionary<String, Int> = ["A": 1, "B": 2, "C": 3, "D": 4]

// Output the ordered dictionary
print(orderedDictionary) // => [A: 1, B: 2, C: 3, D: 4]

// ======================================================= //
// Enumeration
// ======================================================= //

// Loop through the ordered dictionary
for (key, value) in orderedDictionary {
    print("[\(key): \(value)]") // => [A: 1], => [B: 2], => [C: 3], => [D: 4]
}

// Loop through the ordered dictionary with an additional index
for (index, element) in orderedDictionary.enumerated() {
    print("(\(index): [\(element.key): \(element.value)])") // => (0: [A: 1]), => (1: [B: 2]), => (2: [C: 3]), => (3: [D: 4])
}

// ======================================================= //
// Acessing Content
// ======================================================= //

// Access the value for an existing key using the subscript
print(orderedDictionary["A"]) // => Optional(1)

// Access the value for a non-existent key using the subscript
print(orderedDictionary["X"]) // => nil

// Access the value for a key using the method
print(orderedDictionary.value(forKey: "A")) // => Optional(1)

// Access the value for a non-existent key using the method
print(orderedDictionary.value(forKey: "X")) // => nil

// Access the key-value pair (element) at an existing index
print(orderedDictionary[2]) // => ("C", 3)

// Access the key-value pair (element) at a non-existent index
//print(orderedDictionary[10]) // => fatal error

// Get the index for an existing key
print(orderedDictionary.index(forKey: "D")) // => Optional(3)

// ======================================================= //
// Modifying Content Using Keys
// ======================================================= //

// Modify the value for an existing key using the subscript
orderedDictionary["A"] = 100
print(orderedDictionary["A"]) // => Optional(100)

// Modify the value for an existing key using the method
orderedDictionary.updateValue(42, forKey: "D")
print(orderedDictionary["D"]) // => Optional(42)

// Append a new key-value pair by setting a value for an non-existent key
orderedDictionary["E"] = 5
print(orderedDictionary) // => [A: 100, B: 2, C: 3, D: 42, E: 5]

// Remove a key-value pair by setting `nil` value for an existing key
orderedDictionary["B"] = nil
print(orderedDictionary["B"]) // => nil
print(orderedDictionary) // => [A: 100, C: 3, D: 42, E: 5]

// ======================================================= //
// Modifying Content Using Indexes
// ======================================================= //

// Modify an element at an existing index
let replacedElement = orderedDictionary.update(("F", 235), at: 2)
print(orderedDictionary[2]) // => ("F", 235)
print(orderedDictionary) // => [A: 100, C: 3, F: 235, E: 5]
print(replacedElement) // => Optional("D", 42)

// Modify an element at a non-existent index
//orderedDictionary.update(("L", 0), at: 100) // => fatal error

// ======================================================= //
// Sorting
// ======================================================= //

// Sort the ordered dictionary using a closure
orderedDictionary.sort {
    if $0.value == $1.value {
        return $0.key < $1.key
    } else {
        return $0.value < $1.value
    }
}

print(orderedDictionary) // => [C: 3, E: 5, A: 100, F: 235]

// ======================================================= //
// Removing Content
// ======================================================= //

// Remove value for an existing key
let removedValue = orderedDictionary.removeValue(forKey: "F")
print(removedValue) // => Optional(235)
print(orderedDictionary["F"]) // => nil
print(orderedDictionary) // => [C: 3, E: 5, A: 100]

// Remove value for a non-existent key
orderedDictionary.removeValue(forKey: "X")
print(orderedDictionary) // => [C: 3, E: 5, A: 100]

// Remove element at an existing index
let removedElement = orderedDictionary.remove(at: 1)
print(removedElement) // => Optional((E, 5))
print(orderedDictionary) // => [C: 3, A: 100]

// Remove element at a non-existent index
orderedDictionary.remove(at: 42)
print(orderedDictionary) // => [C: 3, A: 100]

// Remove all elements
orderedDictionary.removeAll()
print(orderedDictionary) // => [:]
