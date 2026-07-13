#!/usr/bin/env bash
set -euo pipefail

RG_NAME="${1:-rg-quick-tests}"
ACR_NAME="acrquicktests"

echo "Deleting ACR: $ACR_NAME in resource group: $RG_NAME"
az acr delete --resource-group "$RG_NAME" --name "$ACR_NAME" --yes

echo "ACR '$ACR_NAME' deleted."
