# OrderedDictionary

[![](https://img.shields.io/travis/lukaskubanek/OrderedDictionary.svg?style=flat-square "Build")](https://travis-ci.org/lukaskubanek/OrderedDictionary) [![](https://img.shields.io/badge/release-v1.0.0-blue.svg?style=flat-square)](https://github.com/lukaskubanek/OrderedDictionary/releases) [![](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat-square)](https://developer.apple.com/swift/ "Swift 4") ![](https://img.shields.io/badge/platform-macOS,%20iOS-yellowgreen.svg?style=flat-square "Platform: macOS,%20iOS") [![](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square "Carthage compatible")](https://github.com/Carthage/Carthage) [![](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square "License: MIT")](LICENSE.md)

**OrderedDictionary** is a lightweight implementation of an ordered dictionary data structure in Swift.

The `OrderedDictionary` struct is a generic collection which combines the features of `Dictionary` and `Array` from the Swift standard library. Like `Dictionary` it stores key-value pairs with each key being unique and maps each key to an associated value. Like `Array` it stores those pairs sorted and accessible by a zero-based integer index.

`OrderedDictionary` provides similar APIs like collections from the Swift standard library. This includes accessing contents by keys or indices, inserting and removing elements, iterating, sorting etc.

Internally, `OrderedDictionary` uses a backing store composed of an instance of `Dictionary` for storing the key-value pairs and an instance of `Array` for managing the ordered keys. This means it is not the most performant implementation possible, but it gets its job done by reusing most functionality from the Swift standard library.

## Requirements

- Swift 4
- Xcode 9
- iOS 8.0+ / macOS 10.10+

## Installation

This library is distributed as a Swift framework and can be integrated into your project in following ways:

### Carthage

The easiest way is to use the package manager [Carthage](https://github.com/Carthage/Carthage).

1. Add `github "lukaskubanek/OrderedDictionary"` to your `Cartfile`.
2. Run `carthage bootstrap`.
3. Drag either the `OrderedDictionary.xcodeproj` or the `OrderedDictionary.framework` into your project/workspace and link your target against the `OrderedDictionary.framework`.
4. Make sure the framework [gets copied](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to your application bundle.
5. Import the framework using `import OrderedDictionary`.

### Submodule & Xcode Project

Another option is to use [Git submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules) and integrating the Xcode project `OrderedDictionary.xcodeproj` directly to your Xcode workspace.

## Usage & Docs

For the usage of this library please refer to [the example playground](Playgrounds/OrderedDictionary.playground/Contents.swift). For documentation please refer to [the documentation comments](Sources/OrderedDictionary.swift).

## Changelog

The changelog is managed on the [GitHub releases page](https://github.com/lukaskubanek/OrderedDictionary/releases).

## Author

Lukas Kubanek // [lukaskubanek.com](http://lukaskubanek.com) // [@kubanekl](https://twitter.com/kubanekl)

## License

**OrderedDictionary** is provided under the [MIT License](LICENSE.md).
