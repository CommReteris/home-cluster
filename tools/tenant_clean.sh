#!/bin/bash
for PVC in $(kubectl get persistentvolumeclaims -n minio_tenant | awk '/-lvm/ {print $1}'); do
    echo PVC
    kubectl get persistentvolumeclaim/"$PVC" -o name -n minio-tenant | \
    xargs -I {} kubectl patch {} -n minio-tenant --type merge -p '{"metadata":{"finalizers": []}}'
done
