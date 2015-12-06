# OrderedDictionary

[![][image-1]][1] [![][image-2]][2] [![][image-3]][3] ![][image-4] [![][image-5]][4] [![][image-6]][5]

This is a lightweight implementation of an ordered dictionary data structure in Swift packed into a µframework.

`OrderedDictionary` is an immutable generic collection which combines the features of `Dictionary` and `Array`. Like `Dictionary` it stores key-value pairs and maps the keys to values. Additionally these pairs are sorted by zero-based integer index like in `Array`. The `OrderedDictionary` provides similar APIs to the collections from the Swift standard library, allows accessing the content by keys or indexes and sorting.

Internally `OrderedDictionary` uses a backing store composed of an instance of `Dictionary` for storing the key-value pairs and an instance of `Array` for managing the ordered keys.

## Requirements

- Swift 2.0+
- Xcode 7.0+
- iOS 8.0+ / OS X 10.10+

## Installation

### Carthage

The easiest way to integrate this framework in your project is to use [Carthage](https://github.com/Carthage/Carthage/).

1. Add `github "lukaskubanek/OrderedDictionary" ~> 0.4` to your `Cartfile`.
2. Run `carthage bootstrap`.
3. Drag either the `OrderedDictionary.xcodeproj` or the `LoremSwiftum.framework` into your project/workspace and link your target against the `OrderedDictionary.framework`.
4. Make sure the framework [gets copied](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to your application bundle.

### Submodules

Another option for integrating this framework is to use [Git submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules).

## Example Usage

Initialization:

```swift
var orderedDictionary: OrderedDictionary<String, Int> = [
    ("A", 1),
    ("B", 2),
    ("C", 3),
    ("D", 4)
]

print(orderedDictionary) // => [A: 1, B: 2, C: 3, D: 4]
```

Looping throug the contents:

```swift
for (index, (key, value)) in orderedDictionary.enumerate() {
    print("\(index): (\(key): \(value))")
}

// => 0: (A: 1)
// => 1: (B: 2)
// => 2: (C: 3)
// => 3: (D: 4)
```

Modifying the values by setting the value for key:

```swift
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
```

Modifying the values by setting the element for index:

```swift
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

Sorting:

```swift
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

```

## Author

Lukas Kubanek // [lukaskubanek.com][11] // [@kubanekl][12]

## License

`OrderedDictionary` is released under the [MIT License][13].

[1]:	https://travis-ci.org/lukaskubanek/OrderedDictionary
[2]:	https://github.com/lukaskubanek/OrderedDictionary/releases
[3]:	https://developer.apple.com/swift/
[4]:	https://github.com/Carthage/Carthage
[5]:	LICENSE.md
[6]:	https://github.com/Carthage/Carthage/
[7]:	https://developer.apple.com/swift/
[8]:	https://github.com/lukaskubanek/OrderedDictionary/releases
[9]:	https://developer.apple.com/swift/
[10]:	https://github.com/Carthage/Carthage
[11]:	http://lukaskubanek.com
[12]:	https://twitter.com/kubanekl
[13]:	LICENSE.md

[image-1]:	https://img.shields.io/travis/lukaskubanek/OrderedDictionary.svg?style=flat-square
[image-2]:	https://img.shields.io/github/release/lukaskubanek/OrderedDictionary.svg?style=flat-square
[image-3]:	https://img.shields.io/badge/Swift-2.0-orange.svg?style=flat-square
[image-4]:	https://img.shields.io/badge/platform-OS_X%20&_iOS-yellowgreen.svg?style=flat-square
[image-5]:	https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square "Carthage compatible"
[image-6]:	https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square "License"
