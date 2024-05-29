#!/bin/bash

# ____ FOLDERS _____
APP_FOLDER=~/"Applications"
DESKTOP_FOLDER=~/".local/share/applications"

APP_IMAGE_FOLDER_EXTRACTED="squashfs-root"
# default path of folder created by --appimage-extract command

# ____FILES ____
APP_IMAGE_EXE_NAME="AppRun"

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
ERROR_APP_IMAGE_NOT_FOUND="No .$APP_IMAGE_EXT file found in args"
ERROR_APP_IMAGE_NOT_VALID="The .$APP_IMAGE_EXT does not contain .$ICON_EXT or .$DESKTOP_EXT file"
ERROR_EXTRACTION="AppImage extraction failed. Pls remove folder"

# ____ MESSAGES ____
MSG_FOLDER_EXIST="The folder already exist. Override ? ($YES/$NO)"
MSG_INSTALLATION_FUSE="Fuse is required\n\n    sudo apt install fuse\n"
FINAL_MESSAGE="Installation success"
