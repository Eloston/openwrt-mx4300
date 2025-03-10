#!/bin/bash -ex -o pipefail

type="foss"  #foss nss
ver="snapshot" #snapshot or release#
buildkmod="y"

[ ! -z $1 ] && type=$1
[ ! -z $2 ] && ver=$2
[ ! -z $3 ] && buildkmod=$3

if grep -q "CONFIG_USE_APK=y" .config ; then
  mdfile="${type}-kmod-apk.md"
  warning="APK package manager"
else
  mdfile="${type}-kmod-opkg.md"
  warning="OPKG package manager"
fi

mkdir release

if [ $type = "nss" -a $buildkmod != "n" ]; then
    mkdir kmods
    cp bin/targets/qualcommax/ipq807x/packages/packages* kmods || true # exists if apk
    cp bin/targets/qualcommax/ipq807x/packages/Packages* kmods || true # exists if opkg
    cp bin/targets/qualcommax/ipq807x/packages/kmod-* kmods
    tar cfz kmods.tar.gz kmods/
    cp kmods.tar.gz release/
    kmodmsg="- [use kmods](https://github.com/${GITHUB_REPOSITORY}/blob/build/doc/${mdfile})"
fi

cp .config release/fullconfig.buildinfo
cp bin/targets/qualcommax/ipq807x/openwrt-*-ipq807x-linksys_mx4300-* release/
cp bin/targets/qualcommax/ipq807x/openwrt-*-ipq807x-linksys_mx4300.manifest release/

if [ $type = "foss" ]; then
    cp bin/targets/qualcommax/ipq807x/openwrt-imagebuilder* release/
    kernel=$(cat release/*linksys_mx4300.manifest | grep ^kernel)
else
    kernel=$(cat release/*linksys_mx4300.manifest | grep ^kernel | cut -d '~' -f 1)
fi

checksum=$(sha256sum release/* | sed 's/release\///')

MD="note.md"

echo "- $warning
- $kernel
- sha256sum
\`\`\`
$checksum
\`\`\` 
$kmodmsg" > $MD

