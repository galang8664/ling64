#!/bin/bash

set -e
set -x

# sync rom
repo init -u https://github.com/crdroidandroid/android.git -b 13.0
git clone https://gitlab.com/R9Lab/Manifest.git --depth 1 -b LineageOS-13 .repo/local_manifests
repo sync

# build rom
. build/envsetup.sh
brunch lava
m aex -j$(nproc --all)

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/mido/*.zip
