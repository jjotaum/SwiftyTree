#!/bin/sh
swift package clean
swift test
swift build -c release
cp .build/release/Groot $1/groot
