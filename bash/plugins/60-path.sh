#!/bin/bash

paths=("$HOME/.bin" "/opt/android-sdk/tools")

for i in $paths; do
	add_to_path $i
done
