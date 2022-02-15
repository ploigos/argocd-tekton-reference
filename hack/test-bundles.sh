#!/bin/sh
set -e

oc apply -f pvcs.yaml

oc create -f pipelineruns/everything-bundles.yaml
sleep 1
tkn pipelinerun describe --last
