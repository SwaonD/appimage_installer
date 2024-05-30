#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
SCRIPT_DIR_NAME=$(basename "$SCRIPT_DIR")
CORE_DIR=~/".local/share"
BIN_DIR=~/".local/bin"

SYMLNK_FILE_NAME="appimage-install"

FINAL_MESSAGE="Uninstall complete."

main() {
	local answer

	if [ -f "$BIN_DIR/$SYMLNK_FILE_NAME" ]; then
		rm "$BIN_DIR/$SYMLNK_FILE_NAME"
	fi
	echo "$FINAL_MESSAGE"
	rm -rf "$CORE_DIR/$SCRIPT_DIR_NAME"
}

main
