tkn pipeline start build-and-deploy \
    -w name=shared-workspace,volumeClaimTemplateFile=pvc.yaml \
    -p deployment-name=pipelines-vote-ui \
    -p git-url=https://github.com/ploigos-reference-apps/pipelines-vote-ui.git \
    -p IMAGE=image-registry.openshift-image-registry.svc:5000/quickstart-app-buildah-and-oc/pipelines-vote-ui \
    -p TLSVERIFY=false \
    --use-param-defaults

#tkn pipeline start build-and-deploy \
#    -w name=shared-workspace,volumeClaimTemplateFile=pvc.yaml \
#    -p deployment-name=pipelines-vote-api \
#    -p git-url=https://github.com/ploigos-reference-apps/pipelines-vote-api.git \
#    -p IMAGE=image-registry.openshift-image-registry.svc:5000/quickstart-app-buildah-and-oc/pipelines-vote-api \
#    -p TLSVERIFY=false \
#    --use-param-defaults

