#!/bin/bash

REPOS=$(dirname $0)/repos
mkdir -p $REPOS
docker run --rm -p 8080:80 -v $REPOS:/var/lib/git cirocosta/gitserver-http:formatting
