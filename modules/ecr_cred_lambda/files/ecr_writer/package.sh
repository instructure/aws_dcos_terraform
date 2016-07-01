#!/bin/bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

die () {
  echo >&2 "$@"
  exit 1
}

# check for the existince of the tools we need
hash zip 2>/dev/null || die "require zip"

if [ "$#" -ne 1 ]; then
  die "Usage: ./boostrap.sh output_zip"
fi

outputFile=$1

cd $DIR
echo "fetching deps"
npm install .

zip -r $outputFile write_cred.js config.json node_modules || die "failed to wrip zip"
echo "done"
