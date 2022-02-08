#!/bin/sh
set -e
./cleanup.sh
./build.sh
./test.sh
