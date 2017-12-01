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
  die "Usage: ./boostrap.sh cluster_name num_masters bucket_name exhibitor_prefix exhibitor_address dcos_version"
fi

export DCOS_CLUSTER_NAME="$1"
export DCOS_NUM_MASTERS="$2"
export DCOS_BUCKET="$3"
export DCOS_EXHIBITOR_PREFIX="$4"
export DCOS_EXHIBITOR_ADDRESS="$5"
export DCOS_BOOTSTRAP_URL="file:///tmp/dcos_bootstrap"
export DCOS_VERSION="$6"

export DCOS_EXHIBITOR_BUCKET="$DCOS_BUCKET"
export DCOS_AWS_REGION=${AWS_REGION:-us-east-1}
outputLoc="s3://${DCOS_BUCKET}/${DCOS_CLUSTER_NAME}/${DCOS_VERSION}/bootstrap/"
dcosDl="${DCOS_URL:-https://downloads.dcos.io/dcos/stable/${DCOS_VERSION}/dcos_generate_config.sh}"
dcosFile=${DCOS_INSTALLER:-dcos_generate_config.sh}

ensure_dcos $dcosDl $dcosFile

# copy ipdetect into genconf, but makes it easier so we can just gitignore the whole folder
mkdir -p genconf
cp ip-detect genconf/
confd -confdir "${DIR}/confd" -onetime -backend env

bash ${dcosFile}

# Push it up to S3
if [ -z ${DCOS_AWS_ROLE} ]; then
  # not using assume role
  echo "writing bootstrap data to s3 at ${outputLoc} with default credentials"
  aws --region ${DCOS_AWS_REGION} s3 sync genconf/serve/ "${outputLoc}" --delete --acl private
else
  # assume a role
  echo "writing bootstrap data to s3 at ${outputLoc} with role credentials ${DCOS_AWS_ROLE}"
  CREDS="$(aws sts assume-role --role-arn "${DCOS_AWS_ROLE}" \
                            --role-session-name "dcos-bootstrap" \
                            --duration-seconds 900 \
                            --output json)"

  AKI="$(jq -r '.Credentials.AccessKeyId' <<< ${CREDS})"
  SAK="$(jq -r '.Credentials.SecretAccessKey' <<< ${CREDS})"
  ST="$(jq -r '.Credentials.SessionToken' <<< ${CREDS})"

  env -u AWS_SECURITY_TOKEN \
      AWS_ACCESS_KEY_ID="${AKI}" \
      AWS_SECRET_ACCESS_KEY="${SAK}" \
      AWS_SESSION_TOKEN="${ST}" \
      aws --region ${DCOS_AWS_REGION} s3 sync genconf/serve/ "${outputLoc}" --delete --acl private
fi

