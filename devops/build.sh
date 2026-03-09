#!/bin/bash

set -e

TAG=${1:-latest}

echo "GITHUB_TOKEN: $GITHUB_PAT"

SERVICE_NAME="luci-memory"
CONTAINER_BUCKET="us-docker.pkg.dev/gen-lang-client-0057517563/infra-services"

echo "SERVICE_ROOT:" "$SERVICE_ROOT"
echo "LIBS_ROOT:" "$LIBS_ROOT"

DOCKER_BUILDKIT=1 docker build \
    --build-arg GITHUB_PAT="$GITHUB_PAT"\
    -t $SERVICE_NAME:"$TAG"\
    -f Dockerfile \
    ..

docker tag $SERVICE_NAME:"$TAG" $CONTAINER_BUCKET/$SERVICE_NAME:"$TAG"
# docker tag $SERVICE_NAME:"$TAG" $CONTAINER_BUCKET/$SERVICE_NAME:latest

