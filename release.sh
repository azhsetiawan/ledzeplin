#!/usr/bin/env bash

mkdir -p ./release/completion
cp ./bin/ledzeplin ./release/ledzeplin
osacompile -x -o ./release/blackdog.scpt ./bin/blackdog.applescript
cp ./completion/* ./release/completion/

tar -czvf ledzeplin.tar.gz ./release && rm -rf ./release