#!/bin/sh
swift package clean
swift test
swift build -c release
cp .build/release/SwiftyTree /usr/local/bin/swifty-tree
