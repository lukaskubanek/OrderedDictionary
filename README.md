# OrderedDictionary

[![][image-1]][1] [![][image-2]][2] ![][image-3] [![][image-4]][3] [![][image-5]][4]

This is a lightweight implementation of an ordered dictionary data structure in Swift packed into a µframework.

`OrderedDictioary` is an immutable generic collection which combines the features of `Dictionary` and `Array`. Like `Dictionary` it stores key-value pairs and maps the keys to values. Additionally these pairs are sorted by zero-based integer index like in `Array`. The `OrderedDictionary` provides similar APIs to the collections from the Swift standard library and allows accessing the content by keys or indexes.

Internally `OrderedDictionary` uses a backing store composed of an instance of `Dictionary` for storing the key-value pairs and an instance of `Array` for managing the ordered keys.

## Requirements

- Swift 2.0
- Xcode 7.0 beta 6+
- iOS 8.0+ / OS X 10.10+

## Installation

The easiest way to integrate `OrderedDictionary` to your project is to use [Carthage][5]. Add following line to your `Cartfile`:

```
github "lukaskubanek/OrderedDictionary" ~> 0.1
```

Then drag the `OrderedDictionary.xcodeproj` or the `OrderedDictionary.framework` into your project/workspace and link against the `OrderedDictionary.framework`.

Finally make sure the framework gets copied into your application bundle.

## Example Usage

```swift
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
```

## Author

Lukas Kubanek // [lukaskubanek.com][6] // [@kubanekl][7]

## License

OrderedDictionary is release under the [MIT License][8].

[1]:	https://github.com/lukaskubanek/OrderedDictionary/releases
[2]:	https://developer.apple.com/swift/
[3]:	https://github.com/Carthage/Carthage
[4]:	LICENSE.md
[5]:	https://github.com/Carthage/Carthage/
[6]:	http://lukaskubanek.com
[7]:	https://twitter.com/kubanekl
[8]:	LICENSE.md

[image-1]:	https://img.shields.io/github/release/lukaskubanek/OrderedDictionary.svg?style=flat-square
[image-2]:	https://img.shields.io/badge/Swift-2.0_(7b6)-orange.svg?style=flat-square
[image-3]:	https://img.shields.io/badge/Platform-OS_X%20&_iOS-yellowgreen.svg?style=flat-square
[image-4]:	https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square "Carthage compatible"
[image-5]:	https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square "License"