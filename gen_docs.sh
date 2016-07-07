#!/bin/bash

set -e

outDir=${1:-./docs}

function genDocs() {
  terraform-docs md "$1" > "${outDir}/$(basename $1).md"
}

for tfPath in modules/*; do
  echo "building docs for $tfPath"
  genDocs $tfPath
done
