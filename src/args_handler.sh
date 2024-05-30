#!/bin/bash

argsHandler() {
	local arg

	for arg in "$@"; do
		case "$arg" in
		--help)
			cat "$HELP_FILE"
			return 1
			;;
		esac
	done
	return 0
}