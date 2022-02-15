for f in infra/*-secret.yml; do sops -d $f | oc create -f -; done
oc secrets link pipeline gitea-auth

