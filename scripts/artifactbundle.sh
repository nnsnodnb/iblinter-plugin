#!/bin/bash

set -ue

rm -rf IBLinter.artifactbundle.zip IBLinter.artifactbundle

version=$(cat scripts/iblinter_version.txt)

curl -OL "https://github.com/IBDecodable/IBLinter/releases/download/${version}/portable_iblinter.zip"
unzip portable_iblinter.zip && rm portable_iblinter.zip

mkdir -p IBLinter.artifactbundle
mv LICENSE IBLinter.artifactbundle
mv bin IBLinter.artifactbundle

jq -n \
  --arg version "${version}" \
  --arg type "exeutable" \
  --arg path "bin/iblinter" \
  -f ./scripts/info.jq \
  | tee IBLinter.artifactbundle/info.json

zip -r IBLinter.artifactbundle.zip IBLinter.artifactbundle
rm -rf IBLinter.artifactbundle
