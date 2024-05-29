#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
SRC_DIR="$SCRIPT_DIR/src"

source $SRC_DIR/variables.sh
source $SRC_DIR/tools.sh
source $SRC_DIR/create_folder.sh
source $SRC_DIR/setup_files.sh

main() {
	local folder

	exec 3>&1
	folder=$(createFolder "$@")
	if [ $? -eq 0 ]; then
		setupFiles "$folder"
	fi
}

main "$@"
