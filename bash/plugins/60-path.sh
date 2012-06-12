#!/bin/bash

paths=("$HOME/.bin" "/opt/local/bin" "/opt/local/sbin")

for i in $paths; do
	add_to_path $i
done
