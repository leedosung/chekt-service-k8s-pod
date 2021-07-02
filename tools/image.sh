#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: image.sh <path>"
  exit 0
fi

DOCKER_REPO_URL=289952279049.dkr.ecr.ap-northeast-2.amazonaws.com/chekt/dealer-api
APP_PATH=app/dealer/dev

cd $APP_PATH
ret=$?
if [ $ret -eq 1 ]; then
  echo "invalid path $APP_PATH"
  exit $ret
fi

kustomize edit set image $DOCKER_REPO_URL:"$1"
ret=$?
if [ $ret -eq 1 ]; then
  echo "kustomize set image error"
  exit $ret
fi

cat kustomization.yaml

exit 0
