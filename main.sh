#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

# ____ PRGM DIRECTORIES ____
SRC_DIR="$SCRIPT_DIR/src"
DATA_DIR="$SCRIPT_DIR/data"
TEMP_DIR="$SCRIPT_DIR/temp"

# ____ PRGM FILES ____
HELP_FILE="$DATA_DIR/help"

source "$SRC_DIR/variables.sh"
source "$SRC_DIR/tools.sh"
source "$SRC_DIR/args_handler.sh"
source "$SRC_DIR/create_folder.sh"
source "$SRC_DIR/setup_files.sh"

main() {
	local folder

	argsHandler "$@" || return $?
	exec 3>&1
	mkdir -p $TEMP_DIR
	rm -f "$TEMP_DIR/*"
	folder=$(createFolder "$@") || return $?
	setupFiles "$folder"
	rm -rf "$TEMP_DIR"
}

main "$@"
