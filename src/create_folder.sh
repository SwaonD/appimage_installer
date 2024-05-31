#!/bin/bash

fileExists() {
	local dir=$1
	local name=$2

	if find "$dir" -maxdepth 1 -name "$name" -print -quit | grep -q .; then
		return 0
	else
		return 1
	fi
}

isFolderValid() {
	if ! fileExists "$APP_IMAGE_EXTRACTED_DIR" "*.$DESKTOP_EXT" ||
	! fileExists "$APP_IMAGE_EXTRACTED_DIR" "*.$ICON_EXT" ||
	! fileExists "$APP_IMAGE_EXTRACTED_DIR" "$APP_IMAGE_EXE_NAME"; then
		handleError $CODE_ERROR_INIT "${BASH_SOURCE[1]}" "${FUNCNAME[0]}" \
			$LINENO "$ERROR_APP_IMAGE_NOT_VALID"
		return $CODE_ERROR_INIT
	fi
	return 0
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
	handleError $CODE_ERROR_ARGS "${BASH_SOURCE[1]}" "${FUNCNAME[0]}" $LINENO \
		"$ERROR_APP_IMAGE_NOT_FOUND"
	return $CODE_ERROR_ARGS
}

extractAppImage() {
	local file
	local folder_name

	file=$1
	print "$(MSG_APP_IMAGE_EXTRACTION "$(basename "$file")")"
	"$file" --appimage-extract > /dev/null
	isFolderValid || return $?
	folder_name=$(echo "$(basename "$file")" | cut -f 1 -d '.')
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
		print "$(MSG_FOLDER_EXIST "$APP_DIR/$folder_name")"
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
	moveFolder "$folder_name" || return 1
	print "$(MSG_FOLDER_CREATED "$folder_name" "$APP_DIR")"
	echo "$(realpath "$APP_DIR/$folder_name")"
	return 0
}
