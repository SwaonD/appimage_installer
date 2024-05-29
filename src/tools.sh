#!/bin/bash

print() {
	echo -e "$1" >&3
}

handleError() {
	local exit_code=$1
	local msg=$2
	local line=$3

	echo "Error $exit_code at line $line: $msg" >&2
}
