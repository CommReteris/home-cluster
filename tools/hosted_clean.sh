#!/bin/bash
for PVC in $(kubectl get persistentvolumeclaims -n hosted | awk '/-lvm/ {print $1}'); do
    echo PVC
    kubectl get persistentvolumeclaim/"$PVC" -o name -n hosted | \
    xargs -I {} kubectl patch {} -n hosted --type merge -p '{"metadata":{"finalizers": []}}'
done
