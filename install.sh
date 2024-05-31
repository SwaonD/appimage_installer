#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
CORE_DIR=~/".local/share"
BIN_DIR=~/".local/bin"

SCRIPT_DIR_NAME=$(basename "$SCRIPT_DIR")
GIT_DIR_NAME=".git"

SYMLNK_FILE_NAME="appimage-install"
MAIN_FILE_NAME="main.sh"

YES="y"
NO="n"

MSG_FOLDER_EXISTS="Folder already exist. Replace it ? ($YES/$NO)"
MSG_FILE_COPIED() { echo "$1 copied into $2"; }
MSG_SYMBOLIC_LINK_CREATED() { echo "Symbolic link $1 created in $2"; }
MSG_INSTALL_COMPLETE="Installation completed.\nSee usage with:\n\n    $SYMLNK_FILE_NAME --help\n"
MSG_INSTALL_CANCEL="Installation canceled"

main() {
	local answer

	if [ -d "$CORE_DIR/$SCRIPT_DIR_NAME" ]; then
		echo -e "$CORE_DIR/$SCRIPT_DIR_NAME\n$MSG_FOLDER_EXISTS"
		read -r answer
		if [ "$answer" = "$YES" ]; then
			rm -rf "$CORE_DIR/$SCRIPT_DIR_NAME"
		else
			echo "$MSG_INSTALL_CANCEL"
			return
		fi
	fi
	rsync -av --exclude="$GIT_DIR_NAME" "$SCRIPT_DIR" "$CORE_DIR"
	echo "$(MSG_FILE_COPIED "$SCRIPT_DIR_NAME" "$CORE_DIR")"
	mkdir -p $BIN_DIR
	ln -sf "$CORE_DIR/$SCRIPT_DIR_NAME/$MAIN_FILE_NAME" \
		"$BIN_DIR/$SYMLNK_FILE_NAME"
	echo "$(MSG_SYMBOLIC_LINK_CREATED "$SYMLNK_FILE_NAME" "$BIN_DIR")"
	echo -e "$MSG_INSTALL_COMPLETE"
}

main
