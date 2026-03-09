#!/bin/bash

set -e

TAG=${1:-latest}

SERVICE_NAME="luci-memory"
CONTAINER_BUCKET="us-docker.pkg.dev/gen-lang-client-0057517563/infra-services"

docker push $CONTAINER_BUCKET/$SERVICE_NAME:$TAG
# docker push $CONTAINER_BUCKET/$SERVICE_NAME:latest