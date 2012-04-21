#!/bin/bash

paths=("$HOME/.bin" "/opt/android-sdk/tools")

function add_to_path {
	[ -z `expr $PATH : '.*\('$1'\).*'` ] && export PATH=$PATH:$1
}

for i in $paths; do
	add_to_path $i
done
