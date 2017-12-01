#!/bin/bash

set -e

errorOnFmt=${1:-false}

function fmtAndValidate() {
  local filesChanged=$(terraform fmt $1)

  if [ ! -z "$filesChanged" ] && [ "$errorOnFmt" == true ]; then
    echo "formatting errors found in $1"
    return 1
  fi

  terraform init $1
  terraform validate --check-variables=false $1
}

echo "checking terraform"
for tfPath in $( find . -name *.tf -print0 | xargs -0 -n 1 dirname | sort -u ); do
  echo "checking $tfPath"
  fmtAndValidate $tfPath
done
