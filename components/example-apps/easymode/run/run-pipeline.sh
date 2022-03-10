tkn pipeline start easymode \
    -w name=shared-workspace,volumeClaimTemplateFile=test-pvc.yml \
    -p deployment-name=pipelines-vote-api \
    -p git-url=https://github.com/openshift/pipelines-vote-api.git \
    -p IMAGE=image-registry.openshift-image-registry.svc:5000/easymode/pipelines-vote-api \
    -p TLSVERIFY=false \
    --use-param-defaults
