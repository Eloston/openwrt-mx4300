#!/bin/bash -eux

SOURCE_REPO=https://github.com/openwrt/openwrt.git
SOURCE_BRANCH='openwrt-24.10'
BUILD_REPO=https://github.com/Eloston/openwrt-mx4300.git
BUILD_BRANCH=build
BUILD_INIT=init_build.sh
BUILD_TYPE=nss
BUILD_VER='24.10.0-rc4'
BUILD_TAG='1e530e5'
BUILD_SYNC=y
BUILD_KMOD=y

. build_base.sh