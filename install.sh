#!/bin/sh
swift package clean
swift test
swift build -c release
cp .build/release/Ceroxylon $1/ceroxylon
ln -sf $1/ceroxylon $1/xylon
