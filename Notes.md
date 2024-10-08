
```sh
####### ADD context #######
gcloud config set project `GCP_ID`
gcloud container clusters list
gcloud container clusters get-credentials `cluster-name` --region=`cluster-region`

# Ensure your context is pointing to cloud kubernetes
kubectl config get-contexts

./secrets.sh

helm install "$APP_INSTANCE_NAME" chart/optimism-id-issuer \
  --create-namespace  --namespace "$NAMESPACE" \
  --set privatekey="$PRIVATE_KEY" \
  --set issuerName="$ISSUER_NAME" \
  --set uiPassword="$UI_PASSWORD" \
  --set mainnet="$MAINNET" \
  --set ethereumUrl="$ETHEREUM_URL" \
  --set ingressEnabled="$INGRESS_ENABLED" \
  --set vaultpwd="$VAULT_PASSWORD" \
  --set rhsmode="$RHS_MODE" \
  --set rhsurl="$RHS_URL" 

helm upgrade "$APP_INSTANCE_NAME" chart/optimism-id-issuer \
  --create-namespace  --namespace "$NAMESPACE" \
      --set appdomain="$APP_DOMAIN" \
    --set uidomain="$UI_DOMAIN" \
    --set apidomain="$API_DOMAIN" \
  --set privatekey="$PRIVATE_KEY" \
  --set issuerName="$ISSUER_NAME" \
  --set uiPassword="$UI_PASSWORD" \
  --set mainnet="$MAINNET" \
  --set ethereumUrl="$ETHEREUM_URL" \
  --set ingressEnabled="$INGRESS_ENABLED" \
  --set vaultpwd="$VAULT_PASSWORD" \
  --set rhsmode="$RHS_MODE" \
  --set rhsurl="$RHS_URL" 

export STATIC_IP="34.42.128.167"

helm upgrade "$APP_INSTANCE_NAME" chart/optimism-id-issuer \
  --create-namespace  --namespace "$NAMESPACE" \
  --set staticip="34.120.11.6"
  --set privatekey="$PRIVATE_KEY" \
  --set issuerName="$ISSUER_NAME" \
  --set uiPassword="$UI_PASSWORD" \
  --set mainnet="$MAINNET" \
  --set ethereumUrl="$ETHEREUM_URL" \
  --set vaultpwd="$VAULT_PASSWORD" \
  --set rhsmode="$RHS_MODE" \
  --set rhsurl="$RHS_URL"


helm install "$APP_INSTANCE_NAME" chart/optimism-id-issuer `
    --create-namespace --namespace "$NAMESPACE" \
    --set appdomain="$APP_DOMAIN" \
    --set uidomain="$UI_DOMAIN" \
    --set apidomain="$API_DOMAIN" \
    --set privatekey="$PRIVATE_KEY" \
    --set mainnet="$MAINNET" \
    --set uiPassword="$UIPASSWORD" \
    --set issuerName="$ISSUERNAME" \
    --set issuerEthereumUrl="$ISSUER_ETHERUM_URL" \
    --set ingressEnabled="$INGRESS_ENABLED" \
    --set vaultpwd="$VAULT_PWD" \
    --set rhsMode="$RHS_MODE" \
    --set rhsurl="$RHS_URL" \
    --set-json issuerCustomDidMethods="$ISSUER_CUSTOM_DID_METHODS" \
    --set issuerUiInsecure=$UI_INSECURE \
    --set staticip="$STATIC_IP"


export APP_INSTANCE_NAME=issuer
export NAMESPACE=default
export APP_DOMAIN=app.34.111.150.140.nip.io
export UI_DOMAIN=ui.34.111.150.140.nip.io
export API_DOMAIN=api.34.111.150.140.nip.io
export PRIVATE_KEY="c64d6375895d0adb2602ef859cdac54266628eb1029602a6a40008270e90c93d"
export MAINNET=false
export UIPASSWORD="my cool password"
export ISSUERNAME="OPID Issuer"
export ISSUER_ETHERUM_URL="https://opt-sepolia.g.alchemy.com/v2/5600JheK0TTROlJ6O0wrc0gF3W9wIqm8"
export INGRESS_ENABLED=true
export VAULT_PWD=pepe
export RHS_MODE=OnChain
export RHS_URL="https://rhs-staging.polygonid.me/"
export ISSUER_CUSTOM_DID_METHODS="[]"
export STATIC_IP="my-cool-ip"
```