#!/usr/bin/env bash
set -euo pipefail

RG_NAME="${1:-rg-quick-tests}"
LOCATION="${2:-centralus}"
ACR_NAME="acrquicktests"

if az group show --name "$RG_NAME" &>/dev/null; then
    echo "Resource group '$RG_NAME' already exists."
else
    echo "Creating resource group: $RG_NAME in $LOCATION"
    az group create --name "$RG_NAME" --location "$LOCATION"
fi

echo "Creating Azure Container Registry: $ACR_NAME"
az acr create \
    --resource-group "$RG_NAME" \
    --name "$ACR_NAME" \
    --sku Basic \
    --admin-enabled true

echo "Retrieving ACR credentials..."
ACR_USERNAME=$(az acr credential show \
    --resource-group "$RG_NAME" \
    --name "$ACR_NAME" \
    --query username \
    --output tsv)

ACR_PASSWORD=$(az acr credential show \
    --resource-group "$RG_NAME" \
    --name "$ACR_NAME" \
    --query passwords[0].value \
    --output tsv)

ACR_LOGIN_SERVER=$(az acr show \
    --resource-group "$RG_NAME" \
    --name "$ACR_NAME" \
    --query loginServer \
    --output tsv)

echo ""
echo "=== Azure Container Registry created ==="
echo "Login Server: $ACR_LOGIN_SERVER"
echo "Username:     $ACR_USERNAME"
echo "Password:     $ACR_PASSWORD"
echo ""
echo "Use these values to set GitHub Secrets:"
echo "  ACR_LOGIN_SERVER=$ACR_LOGIN_SERVER"
echo "  ACR_USERNAME=$ACR_USERNAME"
echo "  ACR_PASSWORD=$ACR_PASSWORD"
