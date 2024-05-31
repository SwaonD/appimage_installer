#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
SCRIPT_DIR_NAME=$(basename "$SCRIPT_DIR")
CORE_DIR=~/".local/share"
BIN_DIR=~/".local/bin"

SYMLNK_FILE_NAME="appimage-install"

MSG_CONFIRMATION() { echo "Removing\n$1\n$2\nConfirm? (y/n)"; }
MSG_UNINSTALL_COMPLETE="Uninstall completed."
MSG_UNINSTALL_CANCEL="Uninstall canceled"

main() {
	local answer

	echo -e "$(MSG_CONFIRMATION "$BIN_DIR/$SYMLNK_FILE_NAME" \
		"$CORE_DIR/$SCRIPT_DIR_NAME")"
	read answer
	if [ "$answer" = "y" ]; then
		if [ -f "$BIN_DIR/$SYMLNK_FILE_NAME" ]; then
			rm "$BIN_DIR/$SYMLNK_FILE_NAME"
		fi
		echo "$MSG_UNINSTALL_COMPLETE" # cheat, I know, don't tell anyone
		if [ -d "$CORE_DIR/$SCRIPT_DIR_NAME" ]; then
			rm -r "$CORE_DIR/$SCRIPT_DIR_NAME"
		fi
	else
		echo "$MSG_UNINSTALL_CANCEL"
	fi
}

main
