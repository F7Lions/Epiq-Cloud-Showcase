# Epiq Cloud DevOps - Project 1 Deployment Script
# Client: TBC(To be confirmed)

$RG_NAME = "rg-epiq-test"
$LOCATION = "southeastasia"
$DEPLOYMENT_NAME = "Epiq-Project1-$(Get-Date -Format 'yyyyMMdd-HHmm')"

# Use Get-Item to resolve the path properly relative to the script's location
$TEMPLATE_PATH = Resolve-Path "$PSScriptRoot/../infra/main.bicep"

Write-Host "--- Starting Deployment for Project 1 ---" -ForegroundColor Cyan

# 1. Ensure Resource Group exists
if ((az group exists --name $RG_NAME) -eq "false") {
    Write-Host "Creating Resource Group..." -ForegroundColor Yellow
    az group create --name $RG_NAME --location $LOCATION
}

# 2. Execute Deployment
Write-Host "Deploying IM8-Hardened Landing Zone..." -ForegroundColor Yellow
az deployment group create `
    --name $DEPLOYMENT_NAME `
    --resource-group $RG_NAME `
    --template-file $TEMPLATE_PATH `
    --output json

Write-Host "--- Deployment Task Complete ---" -ForegroundColor Green