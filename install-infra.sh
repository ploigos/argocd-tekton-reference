sops -d infra/sonar-settings-secret.yml | oc create -f -
