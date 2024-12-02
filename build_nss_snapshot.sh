#!/bin/bash -eux

SOURCE_REPO=https://github.com/openwrt/openwrt.git
SOURCE_BRANCH=main
BUILD_REPO=https://github.com/arix00/openwrt-mx4300.git
BUILD_BRANCH=build
BUILD_INIT=init_build.sh
BUILD_TYPE=nss
BUILD_VER=snapshot
BUILD_TAG=""
BUILD_SYNC=n
BUILD_KMOD=y

#git clone $SOURCE_REPO --branch $SOURCE_BRANCH ../openwrt
#[ ! -z $BUILD_TAG ] && git checkout $BUILD_TAG
_repo=$(dirname $(readlink -f $0))
cd ../openwrt
git restore .
git clean -fd
git switch $SOURCE_BRANCH
git pull
cp ${_repo}/script/*.sh ../openwrt/

bash $BUILD_INIT $BUILD_TYPE $BUILD_VER $BUILD_SYNC $BUILD_TAG
./scripts/feeds update -a && ./scripts/feeds install -a

bash genconfig_${BUILD_TYPE}.sh ${BUILD_VER} ${BUILD_KMOD}

make -j$(nproc) world

bash release.sh ${BUILD_TYPE} ${BUILD_VER} ${BUILD_KMOD}
