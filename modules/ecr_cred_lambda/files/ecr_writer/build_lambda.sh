#!/bin/bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

die () {
  echo >&2 "$@"
  exit 1
}

# check for the existince of the tools we need
hash zip 2>/dev/null || die "require zip"

if [ "$#" -ne 3 ]; then
  die "Usage: ./boostrap.sh env_name config destS3Path"
fi

envName=$1
config=$2
destS3Path=$3
outputFile="write_creds.zip"

cd $DIR
echo "fetching deps"
npm install .

echo "writing lambda package for $envName to $outputFile"
echo "${config}" > config.json || die "failed to write config"

zip -r $outputFile write_cred.js config.json node_modules || die "failed to write zip"

aws s3 cp $outputFile $destS3Path || die "failed to upload to s3"

echo "done"
