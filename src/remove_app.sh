#!/bin/bash

removeAppFiles() {
	local desktop_file_name
	local app_name
	local appimage_dir
	local answer
	local config_file

	app_name=$1
	appimage_dir=$2
	desktop_file_name=$(basename "$(find "$appimage_dir" -maxdepth 1 \
		-name "*.$DESKTOP_EXT" -print -quit)")
	print "$(MSG_DIR_REMOVE "$appimage_dir")"
	rm -r "$appimage_dir"
	desktop_file="$DESKTOP_DIR/$desktop_file_name"
	if [ -f "$desktop_file" ]; then
		print "$(MSG_DIR_REMOVE "$desktop_file")"
		rm "$desktop_file"
	fi
	config_file="$CONFIG_DIR/$app_name"
	if [ -d "$config_file" ]; then
		print "$(MSG_CONFIRM_DELETE_DIR "$config_file")"
		read -r answer
		if [ "$answer" = "$YES" ]; then
			print "$(MSG_DIR_REMOVE "$config_file")"
			rm -r "$config_file"
		fi
	fi
}

removeApp() {
	local app_name
	local appimage_dir
	local command_name

	app_name=$1
	command_name=$2
	if [ "$app_name" = "" ]; then
		print "$(MSG_APP_NAME_REQUIRED "$command_name")"
		return
	fi
	appimage_dir=$(find "$APP_DIR" -maxdepth 1 -name "$app_name" -print -quit)
	if ! [ "$appimage_dir" = "" ]; then
		removeAppFiles "$app_name" "$appimage_dir"
		print "$(MSG_APP_UNINSTALLED "$app_name")"
		print "$MSG_DISCLAIMER_UNINSTALLATION" # temp
	else
		print "$(MSG_APP_NOT_FOUND "$app_name")"
	fi
}
