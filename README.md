# Overview

Optimism ID issuer refers to the entity responsible for issuing unique identifiers, known as Optimism IDs, on the Optimism network. The Optimism network is a popular Layer 2 scaling solution for Ethereum, designed to improve scalability and reduce transaction costs.

To learn more about Polygon ID issuer, see [this](TODO:).

## Architecture

![Architecture diagram](resources/polygon-id-issuer-k8s-app-architecture.png)

# Installation

## Command line instructions

You can use [Google Cloud Shell](https://cloud.google.com/shell/) or a local
workstation to complete the following steps.


### Prerequisites

#### Set up command-line tools

Make sure you have these tools installed.

- [gcloud](https://cloud.google.com/sdk/gcloud/)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)
- [docker](https://docs.docker.com/install/)
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [helm](https://helm.sh/)

Configure `gcloud` as a Docker credential helper:

```shell
gcloud auth configure-docker
```

#### Create a Google Kubernetes Engine cluster

If you have an existing GKE cluster you can use that otherwise you can create a new cluster from the command line.

```shell
export CLUSTER=YOUR_CLUSTER_NAME
export PROJECT=YOUR_PROJECT_ID
export REGION=YOUR_REGION
export ZONE=YOUR_ZONE

gcloud container clusters create $CLUSTER --region=$REGION --project $PROJECT
```

Configure `kubectl` to connect to the new cluster.

```shell
gcloud container clusters get-credentials $CLUSTER --region=$REGION --project $PROJECT
```

For zonal clusters, use --zone=ZONE instead of --region=REGION.

#### Requests a static ip

```sh
gcloud compute addresses create ip-name --global
gcloud compute addresses describe ip-name --global

# ...
# address: 203.0.113.32
# ...
```

### Configure the app with environment variables

Choose the instance name and namespace for the app:

```shell
export APP_INSTANCE_NAME=polygon-id-issuer  #Sample name for the application
export NAMESPACE=default #Namespace where you want to deploy the application
```

### Install the helm chart

```shell
helm install "$APP_INSTANCE_NAME" chart/polygon-id-issuer \
  --create-namespace --namespace "$NAMESPACE" \
  --set appdomain="$APP_DOMAIN" \
  --set uidomain="$UI_DOMAIN" \
  --set apidomain="$API_DOMAIN" \
  --set privatekey="$PRIVATE_KEY" \
  --set staticip="$STATIC_IP" \
  --set issuerName="$ISSUER_NAME" \
  --set uiPassword="$UI_PASSWORD" \
  --set mainnet="$MAINNET" \
  --set ethereumUrl="$ETHEREUM_URL" \
  --set vaultpwd="$VAULT_PASSWORD" \
  --set rhsmode="$RHS_MODE" \
  --set rhsurl="$RHS_URL"
```
