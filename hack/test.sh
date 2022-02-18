#!/bin/sh
set -e

oc create -f test/pipelineruns/ci-java.yml
sleep 1
tkn pipelinerun describe --last -o yaml | yq .status.conditions

