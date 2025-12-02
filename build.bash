#!/bin/bash

TAGNAME=${TAGNAME:-dockers.pinacono.com/hoster}

docker build -t ${TAGNAME} .
#docker push dockers.pinacono.com/hoster