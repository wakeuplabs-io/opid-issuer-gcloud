source ./secrets.sh
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