# OrderedDictionary

[![][image-1]][1] [![][image-2]][2] [![][image-3]][3] [![][image-4]][4]

This is a lightweight implementation of an ordered dictionary data structure in Swift packed into a µframework.

`OrderedDictioary` is an immutable generic collection which combines the features of `Dictionary` and `Array`. Like `Dictionary` it stores key-value pairs and maps the keys to values. Additionally these pairs are sorted by zero-based integer index like in `Array`. The `OrderedDictionary` provides similar APIs to the collections from the Swift standard library and allows accessing the content by keys or indexes.

## Example Usage

```swift
import OrderedDictionary

// Initialize an ordered dictionary using an array of key-value pairs
let orderedDictionary: OrderedDictionary<String, Int> = [
    ("A", 1),
    ("B", 2),
    ("C", 3)
]

print(orderedDictionary)
```

## Author

Lukas Kubanek // [lukaskubanek.com][5] // [@kubanekl][6]

## License

OrderedDictionary is release under the [MIT License][7].

[1]:	https://github.com/lukaskubanek/OrderedDictionary/releases
[2]:	https://developer.apple.com/swift/
[3]:	https://github.com/Carthage/Carthage
[4]:	LICENSE.md
[5]:	http://lukaskubanek.com
[6]:	https://twitter.com/kubanekl
[7]:	LICENSE.md

[image-1]:	https://img.shields.io/github/release/lukaskubanek/OrderedDictionary.svg?style=flat-square
[image-2]:	https://img.shields.io/badge/Swift-2.0_(7b6)-orange.svg?style=flat-square
[image-3]:	https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square "Carthage compatible"
[image-4]:	https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square "License"