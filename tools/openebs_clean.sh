#!/bin/bash
for CRD in $(kubectl get crd -n openebs | awk '/lvmvolumes.local.openebs.io/ {print $1}'); do
    echo CRD
    kubectl get -n openebs "$CRD" -o name | \
    xargs -I {} kubectl patch -n openebs {} --type merge -p '{"metadata":{"finalizers": []}}'
done
