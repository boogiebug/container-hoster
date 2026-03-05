#!/bin/bash
VERSION=1.0.0
TAGNAME=${TAGNAME:-dockers.pinacono.com/common/hoster}
DOCKERFILE=Dockerfile

docker buildx build \
  -f $DOCKERFILE \
  -t $TAGNAME:latest \
  -t $TAGNAME:$VERSION \
  --push \
  .