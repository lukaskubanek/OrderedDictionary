# OrderedDictionary

[![][image-1]][1] [![][image-2]][2] [![][image-3]][3] ![][image-4] [![][image-5]][4] [![][image-6]][5]

**OrderedDictionary** is a lightweight implementation of an ordered dictionary data structure in Swift.

The `OrderedDictionary` structure is an immutable generic collection which combines the features of `Dictionary` and `Array` from the Swift standard library. Like `Dictionary` it stores key-value pairs and maps each key to a value. Like `Array` it stores those pairs sorted and accessible by a zero-based integer index.

`OrderedDictionary` provides similar APIs like collections in the Swift standard library. This includes accessing contents by keys or indexes, inserting and removing elements, iterating, sorting etc.

Internally `OrderedDictionary` uses a backing store composed of an instance of `Dictionary` for storing the key-value pairs and an instance of `Array` for managing the ordered keys. This means it is not the most performant implementation possible, but it gets its job done by reusing most functionality from the Swift standard library.

## Requirements

- Swift 3.0
- Xcode 8
- iOS 8.0+ / OS X 10.10+

## Installation

This library is distributed as a Swift framework and can be integrated into your project in following ways:

### Carthage

The easiest way is to use the package manager [Carthage][6].

1. Add `github "lukaskubanek/OrderedDictionary"` to your `Cartfile`.
2. Run `carthage bootstrap`.
3. Drag either the `OrderedDictionary.xcodeproj` or the `OrderedDictionary.framework` into your project/workspace and link your target against the `OrderedDictionary.framework`.
4. Make sure the framework [gets copied][7] to your application bundle.
5. Import the framework using `import OrderedDictionary`.

### Submodule & Xcode Project

Another option is to use [Git submodules][8] and integrating the Xcode project `OrderedDictionary.xcodeproj` directly to your Xcode workspace.

## Usage

For the usage of this library please refer to the [example playground][9].

## Changelog

The changelog is managed on the [GitHub releases page][10].

## Author

Lukas Kubanek // [lukaskubanek.com][11] // [@kubanekl][12]

## License

**OrderedDictionary** is provided under the [MIT License][13].

[1]:	https://travis-ci.org/lukaskubanek/OrderedDictionary
[2]:	https://github.com/lukaskubanek/OrderedDictionary/releases
[3]:	https://developer.apple.com/swift/
[4]:	https://github.com/Carthage/Carthage
[5]:	LICENSE.md
[6]:	https://github.com/Carthage/Carthage
[7]:	https://github.com/Carthage/Carthage#adding-frameworks-to-an-application
[8]:	http://git-scm.com/book/en/v2/Git-Tools-Submodules
[9]:	Playgrounds/OrderedDictionary.playground/Contents.swift
[10]:	https://github.com/lukaskubanek/OrderedDictionary/releases
[11]:	http://lukaskubanek.com
[12]:	https://twitter.com/kubanekl
[13]:	LICENSE.md

[image-1]:	https://img.shields.io/travis/lukaskubanek/OrderedDictionary.svg?style=flat-square "Build"
[image-2]:	https://img.shields.io/github/release/NSLogxiaoyu3/OrderedDictionary.svg?style=flat-square
[image-3]:	https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat-square "Swift 3.0"
[image-4]:	https://img.shields.io/badge/platform-macOS/iOS-yellowgreen.svg?style=flat-square "Platform: OS X, iOS"
[image-5]:	https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square "Carthage compatible"
[image-6]:	https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square "License: MIT"
