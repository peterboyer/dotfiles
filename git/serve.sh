#!/usr/bin/env bash

REPOS=$(dirname $0)/repos
if [[ "${REPOS:0:1}" != "/" ]]; then REPOS=$PWD/${REPOS:2}; fi
mkdir -p $REPOS
docker run --rm -p 8080:80 -v $REPOS:/var/lib/git cirocosta/gitserver-http:formatting
