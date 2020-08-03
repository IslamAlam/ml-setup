#!/bin/bash
DOUBLECMD_VERSION=0.9.9
FileName='doublecmd.x86_64.tar.xz'
FolderName='doublecmd'

cd /tmp
wget -L http://sourceforge.net/projects/doublecmd/files/DC%20for%20Linux%2064%20bit/Double%20Commander%200.9.9%20beta/doublecmd-${DOUBLECMD_VERSION}.qt5.x86_64.tar.xz/download -O $FileName
# wget -L http://sourceforge.net/projects/doublecmd/files/DC%20for%20Linux%2064%20bit/Double%20Commander%200.9.9%20beta/doublecmd-${DOUBLECMD_VERSION}.qt.x86_64.tar.xz/download -O $FileName
# wget -L http://sourceforge.net/projects/doublecmd/files/DC%20for%20Linux%2064%20bit/Double%20Commander%200.9.9%20beta/doublecmd-${DOUBLECMD_VERSION}.gtk2.x86_64.tar.xz/download -O $FileName

mkdir -p $FolderName
mkdir -p $HOME/.local/share/$FolderName
# tar -zxf code.tar.gz --strip-components=1 -C $HOME/.local/share/code
if tar tf $FileName | head -n 1 | grep -q '^./$'; then STRIP_COMPONENTS_COUNT=2; else STRIP_COMPONENTS_COUNT=1; fi
tar xf $FileName --strip-components=$STRIP_COMPONENTS_COUNT -C $FolderName 

cp -r -f $FolderName $HOME/.local/share/

# >> means append to file.
# > means write file from scratch.

cat <<EOF > $HOME/Desktop/$FolderName.desktop
[Desktop Entry]
Name=Double Commander
Comment=Double Commander is a cross platform open source file manager with two panels side by side.
Terminal=false
Icon=$HOME/.local/share/$FolderName/doublecmd.png
Exec=$HOME/.local/share/$FolderName/doublecmd %F
Type=Application
MimeType=inode/directory;
Categories=Utility;FileTools;FileManager;
Keywords=folder;manager;explore;disk;filesystem;orthodox;copy;queue;queuing;operations;
Comment[ru]=Double Commander — это кроссплатформенный двухпанельный файловый менеджер с открытым кодом.

EOF
