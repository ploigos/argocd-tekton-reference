tkn pipeline start build-and-deploy \
    -w name=shared-workspace,volumeClaimTemplateFile=03_persistent_volume_claim.yaml \
    -p deployment-name=pipelines-vote-api \
    -p git-url=https://github.com/openshift/pipelines-vote-api.git \
    -p IMAGE=image-registry.openshift-image-registry.svc:5000/pipelines-tutorial/pipelines-vote-api \
    -p TLSVERIFY=false
    --use-param-defaults
