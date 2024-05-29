#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

source $SCRIPT_DIR/src/variables.sh
source $SCRIPT_DIR/src/tools.sh
source $SCRIPT_DIR/src/create_folder.sh

main() {
	local folder

	exec 3>&1
	folder=$(createFolder "$@")
	if [ $? -eq 0 ]; then
		echo "$folder"
	fi
}

main "$@"
