#!/bin/sh
set -eux -o pipefail

oc create -f test/pipelineruns/java-maven.yml
sleep 1
tkn pipelinerun describe --last -o yaml | yq .status.conditions

