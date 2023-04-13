#!/bin/bash

set -ue

rm -rf IBLinter.artifactbundle.zip IBLinter.artifactbundle

version=$(cat scripts/iblinter_version.txt)

iblinter=$(mktemp -d)
git clone -b "katei/add-cache-path" --depth 1 https://github.com/IBDecodable/IBLinter.git "${iblinter}"
cd "${iblinter}"
swift build --disable-sandbox -c release --static-swift-stdlib --arch arm64 --arch x86_64
BIN_PATH=$(swift build --show-bin-path -c release --arch x86_64 --arch arm64)/iblinter

cd -

mkdir -p IBLinter.artifactbundle
cp "${iblinter}/LICENSE" IBLinter.artifactbundle
mkdir -p "IBLinter.artifactbundle/iblinter-${version}-macos/bin"
cp "${BIN_PATH}" "IBLinter.artifactbundle/iblinter-${version}-macos/bin"

rm -rf "${iblinter}"

jq -n \
  --arg version "${version}" \
  --arg type "executable" \
  --arg path "iblinter-${version}-macos/bin/iblinter" \
  -f ./scripts/info.jq \
  | tee IBLinter.artifactbundle/info.json

zip -r IBLinter.artifactbundle.zip IBLinter.artifactbundle
rm -rf IBLinter.artifactbundle
