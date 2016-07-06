#!/bin/bash

set -e

docker build -t aws_dcos_terraform:test .
docker run --rm aws_dcos_terraform:test
