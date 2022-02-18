#!/bin/sh
set -e

oc create -f test/pipelineruns/java-maven.yml
sleep 1
tkn pipelinerun describe --last -o yaml | yq .status.conditions

