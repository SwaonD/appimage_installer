#!/bin/bash

# ____ FOLDERS _____
APP_FOLDER=~/"Applications"

APP_IMAGE_FOLDER_EXTRACTED="squashfs-root"
# default path of folder created by --appimage-extract command

# ____ EXTENSIONS ____
APP_IMAGE_EXT="AppImage"
DESKTOP_EXT="desktop"
ICON_EXT="png"

# ____ INPUTS ____
YES="y"
NO="n"

# ____ Errors ____
# Error Code
CODE_ERROR_ARGS=100
CODE_ERROR_INIT=101
CODE_ERROR_EXTRACTION=102

# Msgs
ERROR_FILE_NOT_FOUND="No .$APP_IMAGE_EXT file found"
ERROR_APP_IMAGE_NOT_VALID="The .$APP_IMAGE_EXT does not contain .$ICON_EXT or .$DESKTOP_EXT file"
ERROR_EXTRACTION="AppImage extraction failed"

# ____ MESSAGES ____
MSG_FOLDER_EXIST="The folder already exist. Override ? ($YES/$NO)"
