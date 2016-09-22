#!/bin/bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

die () {
  echo >&2 "$@"
  exit 1
}

ensure_dcos () {
  local fullDcosFile="${DIR}/${2}"

  if [ -s "$fullDcosFile" ]; then
    echo "using existing ${dcosFile}"
    chmod a+x $fullDcosFile
    return
  fi
  echo "missing ${2}, downloading, set DCOS_DL_URL to override"
  echo "downloading from ${1} to ${fullDcosFile}"
  curl -o ${fullDcosFile} $1
  chmod a+x $fullDcosFile
}

# check for the existince of the tools we need
hash confd 2>/dev/null || die "require confd"
hash docker 2>/dev/null || die "require docker"

if [ "$#" -ne 6 ]; then
  die "Usage: ./boostrap.sh cluster_name exhibitor_s3_bucket exhibitor_prefix exhibitor_address bootstrap_url s3_output_loc"
fi

export DCOS_CLUSTER_NAME=$1
export DCOS_EXHIBITOR_BUCKET=$2
export DCOS_EXHIBITOR_PREFIX=$3
export DCOS_EXHIBITOR_ADDRESS=$4
export DCOS_BOOTSTRAP_URL=$5
export DCOS_AWS_REGION=${AWS_REGION:-us-east-1}
outputLoc=$6
dcosDl=${DCOS_DL_URL:-https://downloads.dcos.io/dcos/EarlyAccess/dcos_generate_config.sh}
dcosFile=${DCOS_INSTALLER:-dcos_generate_config.sh}

ensure_dcos $dcosDl $dcosFile

# copy ipdetect into genconf, but makes it easier so we can just gitignore the whole folder
mkdir -p genconf
cp ip-detect genconf/
confd -confdir "${DIR}/confd" -onetime -backend env

bash ${dcosFile}

echo "writing bootstrap data to s3 at ${outputLoc}"
aws --region $DCOS_AWS_REGION s3 sync genconf/serve/ $outputLoc
