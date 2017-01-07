#!/bin/bash

if [[ -z $BUILD_DIRECTORY ]]; then
	echo "Error: \$BUILD_DIRECTORY is not set."
	exit 1
fi

if [[ -z $XCODE_PLAYGROUND_TARGET ]]; then
	echo "Error: \$XCODE_PLAYGROUND_TARGET is not set."
	exit 1
fi

PAGES_PATH=Playgrounds/OrderedDictionary.playground/Contents.swift

swift -v -target ${XCODE_PLAYGROUND_TARGET} \
    -D NOT_IN_PLAYGROUND \
    -F ${BUILD_DIRECTORY}/Build/Products/${CONFIGURATION} ${PAGES_PATH} > /dev/null

result=$?

rm -Rf ${BUILD_DIRECTORY}

exit $result
