#!/bin/bash

# ____ DIRECTORIES _____
APP_DIR=~/"Applications"
DESKTOP_DIR=~/".local/share/applications"

APP_IMAGE_EXTRACTED_DIR="squashfs-root"
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

# ____ ERRORS ____
# Error Code
CODE_ERROR_ARGS=100
CODE_ERROR_INIT=101

# Error Msgs
ERROR_APP_IMAGE_NOT_FOUND="No .$APP_IMAGE_EXT file found in args"
ERROR_APP_IMAGE_NOT_VALID="The .$APP_IMAGE_EXT does not contain AppRun, .$ICON_EXT or .$DESKTOP_EXT file"

# ____ MESSAGES ____
MSG_APP_IMAGE_EXTRACTION() { echo "Extraction of $1 ..."; }
MSG_FOLDER_EXIST() { echo "Folder $1 already exist. Replace it ? ($YES/$NO)"; }
MSG_APP_INSTALLATED() { echo "$1 installated with success.\nIf you can't find your application, try to relog."; }
MSG_FOLDER_CREATED() { echo "$1 folder created in $2"; }
MSG_FILE_MOVED() { echo "$1 moved in $2"; }
MSG_INSTALLATION_FUSE="Your app may need FUSE to work properly. Please consider to install it:\n\n    sudo apt install fuse\n"
