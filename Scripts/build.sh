#!/bin/bash

# This script was taken from the ReactiveSwift repository.
# https://github.com/ReactiveCocoa/ReactiveSwift/blob/master/script/build

BUILD_DIRECTORY="build"
CONFIGURATION="Release"

if [[ -z $TRAVIS_XCODE_PROJECT ]]; then
    echo "Error: \$TRAVIS_XCODE_PROJECT is not set."
    exit 1
fi

if [[ -z $TRAVIS_XCODE_SCHEME ]]; then
    echo "Error: \$TRAVIS_XCODE_SCHEME is not set."
    exit 1
fi

if [[ -z $XCODE_ACTION ]]; then
    echo "Error: \$XCODE_ACTION is not set."
    exit 1
fi

if [[ -z $XCODE_SDK ]]; then
    echo "Error: \$XCODE_SDK is not set."
    exit 1
fi

if [[ -z $XCODE_DESTINATION ]]; then
    echo "Error: \$XCODE_DESTINATION is not set."
    exit 1
fi

set -o pipefail
xcodebuild $XCODE_ACTION \
    -project "$TRAVIS_XCODE_PROJECT" \
    -scheme "$TRAVIS_XCODE_SCHEME" \
    -sdk "$XCODE_SDK" \
    -destination "$XCODE_DESTINATION" \
    -derivedDataPath "${BUILD_DIRECTORY}" \
    -configuration $CONFIGURATION \
    ENABLE_TESTABILITY=YES \
    GCC_GENERATE_DEBUGGING_SYMBOLS=NO \
    RUN_CLANG_STATIC_ANALYZER=NO | xcpretty
result=$?

if [ "$result" -ne 0 ]; then
    exit $result
fi

if [[ $XCODE_SDK = "macosx" ]]; then
    echo "SDK is ${XCODE_SDK}, validating playground..."
    . Scripts/validate-playgrounds.sh
fi
