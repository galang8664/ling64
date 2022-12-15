#!/bin/bash

set -e
set -x

# sync rom
repo init -u https://github.com/Evolution-X/manifest -b tiramisu
git clone git clone https://github.com/galang8664/local_manifest.git --depth 1 -b evoxr .repo/local_manifests
repo sync

# build rom
. build/envsetup.sh
lunch evolution_lancelot-userdebug
mka evolution

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/mido/*.zip
