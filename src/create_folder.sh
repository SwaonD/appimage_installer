#!/bin/bash

isFolderValid() {
	if ! fileExists "$APP_IMAGE_EXTRACTED_DIR" "*.$DESKTOP_EXT" ||
	! fileExists "$APP_IMAGE_EXTRACTED_DIR" "*.$ICON_EXT" ||
	! fileExists "$APP_IMAGE_EXTRACTED_DIR" "$APP_IMAGE_EXE_NAME"; then
		print "$MSG_APP_IMAGE_NOT_VALID"
		return $INIT_ERROR_CODE
	fi
	return 0
}

getAppName() {
	local desktop_file
	local folder

	folder="$1"
	desktop_file=$(find "$folder" -maxdepth 1 -name \
		"*.$DESKTOP_EXT" -print -quit)
	echo "$(grep '^Name=' "$desktop_file" | awk -F= '{print $2}' | xargs)"
}

getFile() {
	local file
	local extension

	for file in "$@"; do
		extension="${file##*.}"
		if [ -f "$file" ] && [ "$extension" = "$APP_IMAGE_EXT" ]; then
			echo "$(realpath "$file")"
			return 0
		fi
	done
	print "$MSG_APP_IMAGE_NOT_FOUND"
	return $ARGS_ERROR_CODE
}

extractAppImage() {
	local file
	local folder_name

	file="$1"
	print "$(MSG_APP_IMAGE_EXTRACTION "$(basename "$file")")"
	"$file" --appimage-extract > /dev/null
	isFolderValid || return $?
	folder_name="$(getAppName "$APP_IMAGE_EXTRACTED_DIR")"
	mv "$APP_IMAGE_EXTRACTED_DIR" "$TEMP_DIR"
	mv "$TEMP_DIR/$APP_IMAGE_EXTRACTED_DIR" "$TEMP_DIR/$folder_name"
	echo "$folder_name"
	return 0
}

moveFolder() {
	local answer
	local folder_name

	folder_name=$1
	if ! [ -d "$APP_DIR" ]; then
		mkdir -p "$APP_DIR"
	fi
	if [ -d "$APP_DIR/$folder_name" ]; then
		print "$(MSG_CONFIRM_REPLACE_DIR "$APP_DIR/$folder_name")"
		read -r answer
		if [ "$answer" = "$YES" ]; then
			rm -r "$APP_DIR/$folder_name"
		else
			print "$MSG_APP_INSTALLATION_CANCELED"
			return 1
		fi
	fi
	mv "$TEMP_DIR/$folder_name" "$APP_DIR"
	return 0
}

createFolder() {
	local file
	local folder_name

	file=$(getFile "$@") || return $?
	chmod +x "$file"
	folder_name=$(extractAppImage "$file") || return $?
	moveFolder "$folder_name" || return $?
	print "$(MSG_FOLDER_CREATED "$folder_name" "$APP_DIR")"
	echo "$(realpath "$APP_DIR/$folder_name")"
	return 0
}
