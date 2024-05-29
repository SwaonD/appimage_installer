#!/bin/bash

updateDesktopFile() {
	local folder
	local desktop_file
	local icon_file
	local exe_file

	folder=$1
	desktop_file=$2
	icon_file=$3
	exe_file=$(find "$folder" -name "$APP_IMAGE_EXE_NAME" -print -quit)
	sed -i "s|^Exec=.*|Exec=$exe_file|g" "$desktop_file"
	sed -i "s|^Icon=.*|Icon=$icon_file|g" "$desktop_file"
}

handleFuse() {
	if ! command -v fusermount &> /dev/null; then
		print $MSG_INSTALLATION_FUSE
	fi
}

setupFiles() {
	local folder
	local desktop_file
	local icon_file
	local desktop_file_name

	folder=$1
	desktop_file=$(find "$folder" -name "*.$DESKTOP_EXT" -print -quit)
	icon_file=$(find "$folder" -name "*.$ICON_EXT" -print -quit)
	updateDesktopFile "$folder" "$desktop_file" "$icon_file"
	desktop_file_name=$(basename $desktop_file)
	mv "$desktop_file" "$DESKTOP_FOLDER"
	print "$desktop_file_name moved in $DESKTOP_FOLDER"
	handleFuse
	print "$MSG_INSTALLATION_FUSE"
	print "$FINAL_MESSAGE"
}
