#!/bin/bash

fileExists() {
	local dir=$1
	local name=$2

	if find "$dir" -name "$name" -print -quit | grep -q .; then
		return 0
	else
		return 1
	fi
}

isFolderValid() {
	if ! fileExists "$APP_IMAGE_FOLDER_EXTRACTED" "*.$DESKTOP_EXT" ||
	! fileExists "$APP_IMAGE_FOLDER_EXTRACTED" "*.$ICON_EXT" ||
	! fileExists "$APP_IMAGE_FOLDER_EXTRACTED" "$APP_IMAGE_EXE_NAME"; then
		handleError $CODE_ERROR_INIT "$ERROR_APP_IMAGE_NOT_VALID" $LINENO
		return $CODE_ERROR_INIT
	fi
	return 0
}

getFile() {
	local file
	local extension

	for file in "$@"; do
		extension="${file##*.}"
		if [ -f "$file" ] && [ $extension = $APP_IMAGE_EXT ]; then
			echo "$file"
			return 0
		fi
	done
	handleError $CODE_ERROR_ARGS "$ERROR_APP_IMAGE_NOT_FOUND" $LINENO
	return $CODE_ERROR_ARGS
}

extractAppImage() {
	local file
	local folder_name
	local exit_code

	file=$1
	if ! [ -d "$APP_FOLDER" ]; then
		mkdir -p "$APP_FOLDER"
	fi
	print "Extraction of $(basename "$file") ..."
	"$file" --appimage-extract > /dev/null
	isFolderValid
	exit_code=$?
	if [ $exit_code -ne 0 ]; then
		return $exit_code
	fi
	folder_name=$(basename "$file")
	folder_name=$(echo "$folder_name" | cut -f 1 -d '.')
	if [ -d "$folder_name" ]; then
		rm -r $APP_IMAGE_FOLDER_EXTRACTED
		handleError $CODE_ERROR_EXTRACTION \
			"$ERROR_EXTRACTION $folder_name" $LINENO
		return $CODE_ERROR_EXTRACTION
	fi
	mv "$APP_IMAGE_FOLDER_EXTRACTED" "$folder_name"
	echo "$folder_name"
	return 0
}

createFolder() {
	local file
	local folder_name
	local answer
	local exit_code

	file=$(getFile "$@")
	exit_code=$?
	if [ $exit_code -ne 0 ]; then
		return $exit_code
	fi
	chmod +x "$file"
	folder_name=$(extractAppImage $file)
	exit_code=$?
	if [ $exit_code -ne 0 ]; then
		return $exit_code
	fi
	if [ -d "$APP_FOLDER/$folder_name" ]; then
		print "$APP_FOLDER/$folder_name: $MSG_FOLDER_EXIST"
		read -r answer
		if [ "$answer" = "y" ]; then
			rm -r "$APP_FOLDER/$folder_name"
			mv "$folder_name" "$APP_FOLDER"
		else
			rm -r "$folder_name"
			return 1
		fi
	else
		mv "$folder_name" "$APP_FOLDER"
	fi
	print "$folder_name folder created at $APP_FOLDER"
	echo "$APP_FOLDER/$folder_name"
	return 0
}
