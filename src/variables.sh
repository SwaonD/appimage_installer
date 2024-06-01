#!/bin/bash

# ____ DIRECTORIES ____
APP_DIR=~/"Applications" # DEFAULT DIRECTORY WHERE THE APP WILL BE INSTALLED
DESKTOP_DIR=~/".local/share/applications"
CONFIG_DIR=~/".config"

APP_IMAGE_EXTRACTED_DIR="squashfs-root"
# default name of folder created by --appimage-extract command

# ____FILES ____
APP_IMAGE_EXE_NAME="AppRun"

# ____ EXTENSIONS ____
APP_IMAGE_EXT="AppImage"
DESKTOP_EXT="desktop"
ICON_EXT="png"

# ____ INPUTS ____
YES="y"
NO="n"

# ____ COLORS ____
GREEN="\e[32m"
RESET="\e[0m"

# ____ ERROR CODES ____
ARGS_ERROR_CODE=100
INIT_ERROR_CODE=101

# ____ MESSAGES ____
# infos
MSG_APP_IMAGE_EXTRACTION() { echo "Extraction of $1 ..."; }
MSG_DIR_REMOVE() { echo "Remove $1"; }
MSG_FOLDER_CREATED() { echo "$1 folder created in $2"; }
MSG_FILE_MOVED() { echo "$1 moved in $2"; }
MSG_APP_INSTALLED() { echo "${GREEN}$1 installed with success.$RESET\nIf you can't find your application, try to relog."; }
MSG_APP_UNINSTALLED() { echo "$1 uninstalled with success."; }
MSG_APP_INSTALLATION_CANCELED="Installation canceled."
MSG_INSTALLATION_FUSE="Your app may need FUSE to work properly. Please consider to install it:\n\n    sudo apt install fuse\n"

# confirmations
MSG_CONFIRM_REPLACE_DIR() { echo "$1\nFolder already exist. Replace it ? ($YES/$NO)"; }
MSG_CONFIRM_DELETE_DIR() { echo "Delete $1 ? ($YES/$NO)"; }

# problems
MSG_APP_IMAGE_NOT_VALID="The .$APP_IMAGE_EXT does not contain AppRun, .$ICON_EXT or .$DESKTOP_EXT file"
MSG_APP_IMAGE_NOT_FOUND="No .$APP_IMAGE_EXT file found in args"
MSG_APP_NAME_REQUIRED() { echo "The app name is required after $1"; }
MSG_APP_NOT_FOUND() { echo "App $1 not found."; }


