#!/bin/bash

handleError() {
	local exit_code=$1
	local msg=$2
	local line=$3

	echo "Error $exit_code" >&2
	echo "At line $line: $msg" >&2
}

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
	if ! fileExists "$APP_IMAGE_FOLDER_EXTRACTED" "*.desktop" ||
	! fileExists "$APP_IMAGE_FOLDER_EXTRACTED" "*.png"; then
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
	handleError $CODE_ERROR_ARGS "$ERROR_FILE_NOT_FOUND" $LINENO
	return $CODE_ERROR_ARGS
}

extractAppImage() {
	local file
	local folder_name

	file=$1
	if ! [ -d "$APP_FOLDER" ]; then
		mkdir -p "$APP_FOLDER"
	fi
	"$file" --appimage-extract > /dev/null
	isFolderValid
	if [ $? -ne 0 ]; then
		return $?
	fi
	folder_name=$(basename "$file")
	folder_name=$(echo "$folder_name" | cut -f 1 -d '.')
	if [ -d "$folder_name" ]; then
		rm -r $APP_IMAGE_FOLDER_EXTRACTED
		handleError $CODE_ERROR_EXTRACTION $ERROR_EXTRACTION $LINENO
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

	file=$(getFile "$@")
	if [ $? -ne 0 ]; then
		return $?
	fi
	chmod +x "$file"
	folder_name=$(extractAppImage $file)
	if [ $? -ne 0 ]; then
		return $?
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
	echo "$APP_FOLDER/$folder_name"
	return 0
}
