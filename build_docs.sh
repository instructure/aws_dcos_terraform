#!/bin/bash

set -e

docker build -t aws_dcos_terraform:docs .
docker run -v $(pwd)/docs:/app/docs -t aws_dcos_terraform:docs /app/gen_docs.sh
