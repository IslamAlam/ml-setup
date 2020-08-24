#!/bin/bash
VSCODE_VERSION=1.47.2
cd /tmp
# wget https://github.com/microsoft/vscode/archive/$VSCODE_VERSION.tar.gz -O code.tar.gz
wget -L https://go.microsoft.com/fwlink/?LinkID=620884 -O code.tar.gz

mkdir -p code
mkdir -p $HOME/.local/share/code
# tar -zxf code.tar.gz --strip-components=1 -C $HOME/.local/share/code
if tar tf code.tar.gz | head -n 1 | grep -q '^./$'; then STRIP_COMPONENTS_COUNT=2; else STRIP_COMPONENTS_COUNT=1; fi
tar zxvf code.tar.gz --strip-components=$STRIP_COMPONENTS_COUNT -C code

cp -r -f code $HOME/.local/share/

# >> means append to file.
# > means write file from scratch.

cat <<EOF > $HOME/Desktop/code.desktop
[Desktop Entry]
Name=Visual Studio Code
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=$HOME/.local/share/code/bin/code --unity-launch
Icon=$HOME/.local/share/code/resources/app/resources/linux/code.png
Type=Application
StartupNotify=false
StartupWMClass=Code
Categories=Utility;TextEditor;Development;IDE;
MimeType=text/plain;inode/directory;
Actions=new-empty-window;
Keywords=vscode;

X-Desktop-File-Install-Version=0.23

[Desktop Action new-empty-window]
Name=New Empty Window
Exec=$HOME/.local/share/code/bin/code --new-window
Icon=$HOME/.local/share/code/resources/app/resources/linux/code.png
EOF

desktop-file-install --dir="$HOME/.local/share/applications"  $HOME/Desktop/code.desktop
