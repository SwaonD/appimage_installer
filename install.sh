#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
SCRIPT_DIR_NAME=$(basename "$SCRIPT_DIR")
CORE_DIR=~/".local/share"
BIN_DIR=~/".local/bin"

SYMLNK_FILE_NAME="appimage-install"
MAIN_FILE_NAME="main.sh"

MSG_FOLDER_EXISTS="folder already exist. Replace it ? (y/n)"
FINAL_MESSAGE="Installation done.\nSee usage with:\n\n    $SYMLNK_FILE_NAME --help\n"

main() {
	local answer

	if [ -d "$CORE_DIR/$SCRIPT_DIR_NAME" ]; then
		echo "$CORE_DIR/$SCRIPT_DIR_NAME: $MSG_FOLDER_EXISTS"
		read -r answer
		if [ "$answer" = "y" ]; then
			rm -rf "$CORE_DIR/$SCRIPT_DIR_NAME"
		else
			return 1
		fi
	fi
	cp -r "$SCRIPT_DIR" "$CORE_DIR"
	rm -rf "$CORE_DIR/$SCRIPT_DIR_NAME/.git"
	echo "$SCRIPT_DIR_NAME copied into $CORE_DIR"
	mkdir -p $BIN_DIR
	ln -sf "$CORE_DIR/$SCRIPT_DIR_NAME/$MAIN_FILE_NAME" \
		"$BIN_DIR/$SYMLNK_FILE_NAME"
	echo "Symbolic link $SYMLNK_FILE_NAME created in $BIN_DIR"
	echo -e "$FINAL_MESSAGE"
	return 0
}

main
