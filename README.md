# Overview

Optimism ID issuer refers to the entity responsible for issuing unique identifiers, known as Optimism IDs, on the Optimism network. The Optimism network is a popular Layer 2 scaling solution for Ethereum, designed to improve scalability and reduce transaction costs.

## Architecture

![Architecture diagram](resources/issuer-k8s-app-architecture.png)

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

# example
gcloud beta container --project "op-zk-identity" clusters create "opid-cluster" --region "us-central1" --tier "standard" --no-enable-basic-auth --cluster-version "1.31.5-gke.1023000" --release-channel "regular" --machine-type "e2-medium" --image-type "COS_CONTAINERD" --disk-type "pd-balanced" --disk-size "50" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "1" --logging=SYSTEM,WORKLOAD --monitoring=SYSTEM,STORAGE,POD,DEPLOYMENT,STATEFULSET,DAEMONSET,HPA,CADVISOR,KUBELET --enable-ip-alias --network "projects/op-zk-identity/global/networks/default" --subnetwork "projects/op-zk-identity/regions/us-central1/subnetworks/default" --no-enable-intra-node-visibility --default-max-pods-per-node "110" --enable-ip-access --security-posture=standard --workload-vulnerability-scanning=disabled --no-enable-master-authorized-networks --no-enable-google-cloud-access --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --binauthz-evaluation-mode=DISABLED --enable-managed-prometheus --workload-pool "op-zk-identity.svc.id.goog" --enable-shielded-nodes --node-locations "us-central1-a","us-central1-b","us-central1-c","us-central1-f"
```

Configure `kubectl` to connect to the new cluster.

```shell
gcloud container clusters get-credentials $CLUSTER --region=$REGION --project $PROJECT

# example
gcloud container clusters get-credentials opid-cluster --region us-central1 --project op-zk-identity
```

For zonal clusters, use --zone=ZONE instead of --region=REGION.

#### Request a static ip

```sh
gcloud compute addresses create opid-node --global
gcloud compute addresses describe opid-node --global

# address: 34.8.100.193
# addressType: EXTERNAL
# creationTimestamp: '2025-02-18T10:13:35.869-08:00'
# description: ''
# ipVersion: IPV4
# kind: compute#address
# name: opid-node
# networkTier: PREMIUM
# status: RESERVED
# ...
```

#### Install application resource definition

```
kubectl apply -f "https://raw.githubusercontent.com/GoogleCloudPlatform/marketplace-k8s-app-tools/master/crd/app-crd.yaml"
```

#### Add kubernetes service account

Service account name is `${APP_INSTANCE_NAME}-default-service-account`

```
kubectl create serviceaccount --namespace default issuer-default-service-account 
```

## Enable workload identity on cluster

If you want to do it through CLI, go ahead and follow [this link](https://cloud.google.com/apigee/docs/hybrid/v1.12/enable-workload-identity-gke)
Through UI, under the cluster *details* tab, there should be a section which says Workload Identity, it should be enabled.

## Enable GKE Metadata Server on the node pool

Once Workload Identity is enabled, under the cluster *nodes* tab, go into the node pool details and edit the node pool.

Under the *security section*, the option *Enable GKE Metadata Server* should be enabled.

### Configure the app with environment variables

Create ./scripts/secrets.sh

```shell
export APP_INSTANCE_NAME=issuer
export NAMESPACE=default
export MAINNET=false
export RPC_URL="https://opt-sepolia.g.alchemy.com/v2/..."
export UI_USERNAME=user
export UI_PASSWORD=password
export API_UI_USERNAME=user
export API_UI_PASSWORD=password
export API_USERNAME=user    
export API_PASSWORD=password
export ISSUER_NAME="OPID Issuer"
export PRIVATE_KEY="5a814bcdce11f2..."
export VAULT_PASSWORD=password
export RHS_MODE="OffChain"
export RHS_URL="http://a009ec078484b45e5b233cc29eab9f83-ff4fb4ecca77ee61.elb.us-east-1.amazonaws.com"
export STATIC_IP_NAME="opid-node"

# In case you want to setup a custom domain just replace with it, for example app.mydomain.com, ui.mydomain.com, api.mydomain.com and then create an A record for each subdomain that points to the ip number (example 34.49.6.252)
export APP_HOST=app.34.49.6.252.nip.io  
export UI_HOST=ui.34.49.6.252.nip.io    
export API_HOST=api.34.49.6.252.nip.io  
```

### Install the helm chart

First ensure your kubectl context is pointing to the right project, then run:

```shell
chmod +x ./scripts/install.sh
chmod +x ./scripts/uninstall.sh
chmod +x ./scripts/upgrade.sh

# install
./scripts/install.sh

# uninstall
./scripts/uninstall.sh

# upgrade
./scripts/upgrade.sh
```
