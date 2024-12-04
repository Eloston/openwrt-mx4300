#!/bin/bash -eux

SOURCE_REPO=https://github.com/openwrt/openwrt.git
SOURCE_BRANCH=main
BUILD_REPO=https://github.com/Eloston/openwrt-mx4300.git
BUILD_BRANCH=build
BUILD_INIT=init_build.sh
BUILD_TYPE=nss
BUILD_VER=snapshot
BUILD_TAG=""
BUILD_SYNC=n
BUILD_KMOD=y

. build_base.sh
