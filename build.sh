#!/bin/sh
# Script to download squashfs-tools v4.3, apply the patches, perform a clean build, and install.

# If not root, perform 'make install' with sudo
if [ "$UID" = "0" ]
then
    SUDO=""
else
    SUDO="sudo"
fi

# Install prerequisites
if hash apt-get &>/dev/null
then
    $SUDO apt-get install build-essential liblzma-dev liblzo2-dev zlib1g-dev
fi

# Make sure we're working in the same directory as the build.sh script
cd $(dirname `readlink  -f $0`)

# Download squashfs4.3.tar.gz if it does not already exist
if [ ! -e squashfs4.3.tar.gz ]
then
    # wget https://downloads.sourceforge.net/project/squashfs/squashfs/squashfs4.3/squashfs4.3.tar.gz
    wget https://downloads.sourceforge.net/project/squashfs/squashfs/squashfs4.3/squashfs4.3.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fsquashfs%2Ffiles%2Fsquashfs%2Fsquashfs4.3%2Fsquashfs4.3.tar.gz%2Fdownload%3Fuse_mirror%3Dastuteinternet%26r%3Dhttps%253A%252F%252Fsourceforge.net%252Fprojects%252Fsquashfs%252Ffiles%252Fsquashfs%252Fsquashfs4.3%252Fsquashfs4.3.tar.gz%252Fdownload%253Fuse_mirror%253Diweb&ts=1551828623
fi

# Remove any previous squashfs4.3 directory to ensure a clean patch/build
rm -rf squashfs4.3

# Extract squashfs4.3.tar.gz
tar -zxvf squashfs4.3.tar.gz

# Patch, build, and install the source
cd squashfs4.3
patch -p0 < ../patches/patch0.txt
cd squashfs-tools
make && $SUDO make install
