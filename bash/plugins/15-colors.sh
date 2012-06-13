#!/bin/bash

eval "`dircolors -b`"

# Nice color variables
colors='BLACK RED GREEN BROWN BLUE PURPLE CYAN GRAY'
j=0
for i in $colors; do
	export $i="[0;3${j}m"
	export L_$i="[1;3${j}m"
	let j++
done
export CLEAR="[0;00m"
unset j
