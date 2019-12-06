#!/bin/sh
PAAS_TOKEN=YYYYYYYYYYY
API_TOKEN=XXXXXXXXXXXX
# Dynatrace API Url including /api
TENANT_API=https://tenantid.live.dynatrace.com/api

# Install the operator
echo "Creating dynatrace K8s namespace"
kubectl create namespace dynatrace
LATEST_RELEASE=$(curl -s https://api.github.com/repos/dynatrace/dynatrace-oneagent-operator/releases/latest | grep tag_name | cut -d '"' -f 4)
echo "Creating K8s deployment for the latest oneagent operator release"
kubectl create -f https://raw.githubusercontent.com/Dynatrace/dynatrace-oneagent-operator/$LATEST_RELEASE/deploy/kubernetes.yaml

#kubectl -n dynatrace logs -f deployment/dynatrace-oneagent-operator

kubectl -n dynatrace create secret generic oneagent --from-literal="apiToken=$API_TOKEN" --from-literal="paasToken=$PAAS_TOKEN"

curl -o cr.yaml https://raw.githubusercontent.com/Dynatrace/dynatrace-oneagent-operator/$LATEST_RELEASE/deploy/cr.yaml
sed -i "s+apiUrl: https://ENVIRONMENTID.live.dynatrace.com/api+apiUrl: $TENANT_API+g" cr.yaml
kubectl create -f cr.yaml
echo "Done deploying the oneagent via operator"
