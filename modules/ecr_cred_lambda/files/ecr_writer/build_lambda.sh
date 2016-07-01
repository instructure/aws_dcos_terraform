#!/bin/bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

die () {
  echo >&2 "$@"
  exit 1
}

# check for the existince of the tools we need
hash zip 2>/dev/null || die "require zip"

if [ "$#" -ne 5 ]; then
  die "Usage: ./boostrap.sh env_name registry_id target_bucket target_key output_zip"
fi

envName=$1
registryId=$2
targetBucket=$3
targetKey=$4
outputFile=$5

cd $DIR
echo "fetching deps"
npm install .

echo "writing lambda package for $envName to $outputFile"
echo "{\"targetBucket\": \"$targetBucket\", \"targetKey\": \"$targetKey\", \"registryId\": \"$registryId\"}" > config.json || die "failed to write config"

zip -r $outputFile write_cred.js config.json node_modules || die "failed to wrip zip"
echo "done"
