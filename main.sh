#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
SRC_DIR="$SCRIPT_DIR/src"
TEMP_DIR="$SCRIPT_DIR/temp"

source $SRC_DIR/variables.sh
source $SRC_DIR/tools.sh
source $SRC_DIR/create_folder.sh
source $SRC_DIR/setup_files.sh

main() {
	local folder

	exec 3>&1
	mkdir -p $TEMP_DIR
	rm -f "$TEMP_DIR/*"
	folder=$(createFolder "$@")
	if [ $? -eq 0 ]; then
		setupFiles "$folder"
	fi
	rm -f "$TEMP_DIR/*"
}

main "$@"
