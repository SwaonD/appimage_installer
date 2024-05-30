# Description
This bash script helps install .AppImage files on your session.
You should have at the end the desktop icon in your applications.

# Dependencies
.AppImage format may require FUSE to work properly.<br>
You can check if it is installed with this command:<br>
```sh
which fusermount
```

If nothing returns, consider to install it.<br>
```sh
sudo apt update
sudo apt install fuse3
```

# Installation
```sh
git clone https://github.com/SwaonD/appimage_installer.git
```

# Usage
```sh
./appimage_installer/main.sh <my_file>.AppImage
```
