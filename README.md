# Desciprtion
This bash script helps install .AppImage files on your session.
You should have at the end the desktop icon in your applications.

# Installation
`git clone https://github.com/SwaonD/appimage_installer.git`

.AppImage files may need fuse to work properly.<br>
You can check if you have it with this command:<br>
`which fusermount`

If nothing returns, consider to install it.<br>
`sudo apt install fuse`

# Usage
`./appimage_installer/main.sh <my_file>.AppImage`
