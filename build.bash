#!/bin/bash

TAGNAME=${TAGNAME:-dockers.pinacono.com/common/hoster}

docker build -t ${TAGNAME} .
docker push dockers.pinacono.com/common/hoster