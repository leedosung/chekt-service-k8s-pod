#!/bin/bash

TEST_YAML_NAME=test.yaml

if [ -z "$1" ]; then
  echo "Usage: check.sh <path>"
  exit 0
fi

kustomize build "$1" > $TEST_YAML_NAME
ret=$?
if [ $ret -eq 1 ]; then
  echo "kustomize build error $TEST_YAML_NAME"
  exit $ret
fi

kube-linter lint $TEST_YAML_NAME
ret=$?
if [ $ret -eq 1 ]; then
  echo "kube-linter error $TEST_YAML_NAME"
  exit $ret
fi

kubeval $TEST_YAML_NAME
ret=$?
if [ $ret -eq 1 ]; then
  echo "kubeval error $TEST_YAML_NAME"
  exit $ret
fi

rm $TEST_YAML_NAME

exit 0
