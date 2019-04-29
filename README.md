# OrderedDictionary

[![](https://img.shields.io/travis/lukaskubanek/OrderedDictionary.svg?style=flat-square "Build")](https://travis-ci.org/lukaskubanek/OrderedDictionary) [![](https://img.shields.io/badge/release-v2.2.2-blue.svg?style=flat-square)](https://github.com/lukaskubanek/OrderedDictionary/releases) [![](https://img.shields.io/badge/Swift-4.0+-orange.svg?style=flat-square)](https://developer.apple.com/swift/ "Swift 4") ![](https://img.shields.io/badge/platform-macOS/iOS-yellowgreen.svg?style=flat-square "Platform: macOS/iOS") [![](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square "Carthage compatible")](https://github.com/Carthage/Carthage)
[![](https://img.shields.io/badge/SPM-compatible-brightgreen.svg?style=flat-square "SPM compatible")](https://github.com/Carthage/Carthage) [![](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square "License: MIT")](LICENSE.md)

**OrderedDictionary** is a lightweight implementation of an ordered dictionary data structure in Swift.

The `OrderedDictionary` struct is a generic collection which combines the features of `Dictionary` and `Array` from the Swift standard library. Like `Dictionary` it stores key-value pairs with each key being unique and maps each key to an associated value. Like `Array` it stores those pairs sorted and accessible by a zero-based integer index.

`OrderedDictionary` provides similar APIs like collections from the Swift standard library. This includes accessing contents by keys or indices, inserting and removing elements, iterating, sorting etc.

Internally, `OrderedDictionary` uses a backing store composed of an instance of `Dictionary` for storing the key-value pairs and an instance of `Array` for managing the ordered keys. This means it is not the most performant implementation possible, but it gets its job done by reusing most functionality from the Swift standard library.

## Requirements

- Swift 4.0, 4.2, 5.0
- Xcode 9.2+
- iOS 8.0+ / macOS 10.10+

## Installation

The library is distributed as a Swift framework and can be integrated into your project in following ways:

#### Carthage

If you use [Carthage](https://github.com/Carthage/Carthage) for managing your dependencies, put OrderedDictionary into your `Cartfile`:

```plain
github "lukaskubanek/OrderedDictionary"
```

Then, drag either the `OrderedDictionary.xcodeproj` or the `OrderedDictionary.framework` into your project/workspace and link your target against the `OrderedDictionary.framework`. Also make sure that the framework [gets copied](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to your application bundle.

#### Swift Package Manager

Another option is to use the [Swift Package Manager](https://swift.org/package-manager/). If you prefer this option, put OrderedDictionary as a dependency to your `Package.swift`:

```plain
.package(url: "https://github.com/lukaskubanek/OrderedDictionary.git", from: "2.2.2")
```

#### Git Submodules

Yet another option is using [Git submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules) and integrating the Xcode project `OrderedDictionary.xcodeproj` from the submodule directly to your Xcode workspace.

#### ⚠️ Note About CocoaPods

Although there is high demand for [CocoaPods](https://cocoapods.org) support, this method won't be officially supported by this library. Since I'm not using CocoaPods myself and since I think this method will be once replaced by the Swift Package Manager, I don't want to put any effort in maintaining an official podspec. If you really want to include this library via CocoaPods, there is still a way by creating a custom podspec (see the last section of [this post](https://guides.cocoapods.org/syntax/podfile.html#pod)).

## Usage & Docs

For the usage of this library please refer to [the example playground](Playgrounds/OrderedDictionary.playground/Contents.swift). For documentation please refer to [the documentation comments](Sources/OrderedDictionary.swift).

## Changelog

The changelog is managed on the [GitHub releases page](https://github.com/lukaskubanek/OrderedDictionary/releases).

## Author

Lukas Kubanek // [lukaskubanek.com](http://lukaskubanek.com) // [@kubanekl](https://twitter.com/kubanekl)

## License

**OrderedDictionary** is provided under the [MIT License](LICENSE.md).
