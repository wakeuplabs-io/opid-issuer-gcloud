source ./scripts/secrets.sh
helm upgrade "$APP_INSTANCE_NAME" chart/optimism-id-issuer \
  --create-namespace --set namespace="$NAMESPACE" \
  --set mainnet="$MAINNET" \
  --set issuerEthereumUrl="$RPC_URL" \
  --set uiUsername="$UI_USERNAME" \
  --set uiPassword="$UI_PASSWORD" \
  --set apiUiUsername="$API_UI_USERNAME" \
  --set apiUiPassword="$API_UI_PASSWORD" \
  --set apiUser="$API_USERNAME" \
  --set apiPassword="$API_PASSWORD" \
  --set staticIpName="$STATIC_IP_NAME" \
  --set apphost="$APP_HOST" \
  --set uihost="$UI_HOST" \
  --set apihost="$API_HOST" \
  --set issuerName="$ISSUER_NAME" \
  --set privateKey="$PRIVATE_KEY" \
  --set vaultpwd="$VAULT_PASSWORD" \
  --set rhsmode="$RHS_MODE" \
  --set rhsurl="$RHS_URL" 
