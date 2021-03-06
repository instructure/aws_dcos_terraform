#!/bin/bash

set -e
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

DCOS_VERSION="$6"
dcosDl="${DCOS_URL:-https://downloads.dcos.io/dcos/stable/${DCOS_VERSION}/dcos_generate_config.sh}"

die () {
  echo >&2 "$@"
  exit 1
}

if [ -z ${AWS_ACCESS_KEY_ID+x} ]; then
  die "must have AWS_ACCESS_KEY_ID set"
fi

if [ -z ${AWS_SECRET_ACCESS_KEY+x} ]; then
  die "must have AWS_SECRET_ACCESS_KEY set"
fi

echo "building docker container"
cd $DIR
docker build -t dcos_builder --build-arg SOURCE_DIR=${DIR} --build-arg DCOS_URL=${dcosDl} .
echo "running docker container to build bootstrap"
docker run \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v ${DIR}/genconf:${DIR}/genconf \
  -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
  -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
  -e AWS_SECURITY_TOKEN=${AWS_SECURITY_TOKEN} \
  -e AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN} \
  -e AWS_REGION=${AWS_REGION} \
  -e DCOS_AWS_ROLE=${DCOS_AWS_ROLE} \
  dcos_builder "$@"
