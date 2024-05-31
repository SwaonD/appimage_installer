#!/bin/bash

print() {
	echo -e "$1" >&3
}

handleError() {
	local exit_code=$1
	local file=$2
	local function=$3
	local line=$4
	local msg=$5

	echo -e "Error $exit_code\nIn file $file\nIn function $function at line $line: ${RED}${msg}${RESET}" >&2
}
