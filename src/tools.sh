#!/bin/bash

print() {
	echo -e "$1" >&3
}

fileExists() {
	local dir=$1
	local name=$2

	if find "$dir" -maxdepth 1 -name "$name" -print -quit | grep -q .; then
		return 0
	else
		return 1
	fi
}