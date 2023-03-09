#!/bin/bash
for PVC in $(kubectl get persistentvolumeclaims -n monitoring | awk '/-lvm/ {print $1}'); do
    echo PVC
    kubectl get persistentvolumeclaim/"$PVC" -o name -n monitoring | \
    xargs -I {} kubectl patch {} -n monitoring --type merge -p '{"metadata":{"finalizers": []}}'
done
