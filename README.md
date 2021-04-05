# OrderedDictionary

<p align="left">
    <a href="https://github.com/lukaskubanek/OrderedDictionary/releases">
        <img src="https://img.shields.io/github/release/lukaskubanek/OrderedDictionary/all.svg?style=flat-square">
    </a>
    <a href="https://developer.apple.com/swift">
        <img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat-square" alt="Swift 5.0">
    </a>
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg?style=flat-square" alt="Swift Package Manager">
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat-square" alt="Carthage">
    </a>
    <a href="LICENSE.md">
        <img src="https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square" alt="License: MIT">
    </a>
    <a href="https://twitter.com/lukaskubanek">
        <img src="https://img.shields.io/badge/contact-@lukaskubanek-olive.svg?style=flat-square" alt="Twitter: @lukaskubanek">
    </a>
</p>

OrderedDictionary is a lightweight implementation of an ordered dictionary data structure in Swift.

The `OrderedDictionary<Key: Hashable, Value>` struct is a generic collection that combines the features of the `Dictionary` and `Array` data structures from the Swift standard library. Like `Dictionary`, it stores key-value pairs with each key being unique and maps each key to an associated value. Like `Array`, it stores those pairs sorted and accessible by a zero-based integer index.

`OrderedDictionary` provides similar APIs to collections available in the Swift standard library like accessing contents by keys or indices, inserting and removing elements, iterating, sorting, transforming, filtering, etc.

Internally, `OrderedDictionary` uses backing storage composed of a `Dictionary` for storing the key-value pairs and an `Array` for managing the ordered keys. This is certainly not the most performant implementation one can achieve, but it gets its job done while reusing most functionality from the Swift standard library.

## Requirements

- Swift 5.0 or later
- Xcode 11 or later
- iOS 8 or later / macOS 10.10 or later

*For support of older Swift versions, please refer to older versions of this library. For Swift 4.2, use version 3.x, and for Swift 4.0-4.1, use version 2.x.*

*The requirements for Xcode and OS versions only apply when the library is integrated as a framework or via the Xcode project.*

## Installation

### Swift Package Manager

To install OrderedDictionary using the [Swift Package Manager](https://swift.org/package-manager/), add it as a dependency into your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/lukaskubanek/OrderedDictionary.git", from: "4.0.0")
    ],
    ...
)
```

### Carthage

To install OrderedDictionary using [Carthage](https://github.com/Carthage/Carthage), add it as a dependency into your `Cartfile`:

```plain
github "lukaskubanek/OrderedDictionary" ~> 4.0
```

Then drag either the `OrderedDictionary.xcodeproj` or the `OrderedDictionary.framework` into your Xcode project/workspace and link your target against the `OrderedDictionary.framework`. Make sure that the framework [gets copied](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to your application bundle.

### Git Submodules

You can also install OrderedDictionary via [Git submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules) and integrate the project `OrderedDictionary.xcodeproj` from the submodule directly into your Xcode workspace.

### Note About CocoaPods

Although there has been a high demand for [CocoaPods](https://cocoapods.org) support, this distribution method won't be officially supported by this library. If you really want to integrate this library via CocoaPods, you can create and maintain a custom podspec (see the last section of [this post](https://guides.cocoapods.org/syntax/podfile.html#pod)).

## Usage & Docs

For the explanation of the API of `OrderedDictionary` and examples on how to use this data structure, please refer to the [documentation comments](Sources/OrderedDictionary/OrderedDictionary.swift) or the [comprehensive test suite](Tests/OrderedDictionaryTests).

## Changelog

To view the changelog, refer to GitHub's [releases page](https://github.com/lukaskubanek/OrderedDictionary/releases). If you're upgrading from version 3.x, you might want to check out the list of changes made in [version 4.0](https://github.com/lukaskubanek/OrderedDictionary/releases/tag/v4.0.0).

## Credits

OrderedDictionary was built by [@lukaskubanek](https://twitter.com/lukaskubanek), the founder and  developer of [Diagrams](https://diagrams.app), a native diagram editor for Mac. This data structure is being used extensively for powering Diagrams' data model.
