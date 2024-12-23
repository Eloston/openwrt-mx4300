# Run this with ". build_base.sh" from another script that defines all the variables

#git clone $SOURCE_REPO --branch $SOURCE_BRANCH ../openwrt
_repo=$(dirname $(readlink -f $0))
cd ../openwrt
git restore .
git clean -fdx
git switch $SOURCE_BRANCH
git pull
[ ! -z $BUILD_TAG ] && git checkout $BUILD_TAG
cp ${_repo}/script/*.sh ../openwrt/

bash $BUILD_INIT $BUILD_TYPE $BUILD_VER $BUILD_SYNC $BUILD_TAG
./scripts/feeds update -a && ./scripts/feeds install -a

bash genconfig_${BUILD_TYPE}.sh ${BUILD_VER} ${BUILD_KMOD}

make -j$(nproc) world

bash release.sh ${BUILD_TYPE} ${BUILD_VER} ${BUILD_KMOD}
