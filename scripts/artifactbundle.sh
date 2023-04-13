#!/bin/bash

set -ue

rm -rf IBLinter.artifactbundle.zip IBLinter.artifactbundle

version=$(cat scripts/iblinter_version.txt)

iblinter=$(mktemp -d)
git clone -b "${version}" --depth 1 https://github.com/IBDecodable/IBLinter.git "${iblinter}"
cd "${iblinter}"
swift build --disable-sandbox -c release --static-swift-stdlib --arch arm64 --arch x86_64
BIN_PATH=$(swift build --show-bin-path -c release --arch x86_64 --arch arm64)/iblinter

cd -

mkdir -p IBLinter.artifactbundle/bin
cp "${iblinter}/LICENSE" IBLinter.artifactbundle
cp "${BIN_PATH}" IBLinter.artifactbundle/bin/iblinter

rm -rf "${iblinter}"

jq -n \
  --arg version "${version}" \
  --arg type "exeutable" \
  --arg path "bin/iblinter" \
  -f ./scripts/info.jq \
  | tee IBLinter.artifactbundle/info.json

zip -r IBLinter.artifactbundle.zip IBLinter.artifactbundle
rm -rf IBLinter.artifactbundle
