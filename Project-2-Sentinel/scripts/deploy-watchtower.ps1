$RG_NAME = "rg-epiq-test"
$LOCATION = "southeastasia"
$WORKSPACE_NAME = "law-epiq-watchtower"
$TEMPLATE_PATH = Join-Path $PSScriptRoot "../infra/monitoring.bicep"

Write-Host "--- Starting Project 2: Sentinel Watchtower Deployment ---" -ForegroundColor Cyan

# 1. Deploy the Monitoring Infrastructure
Write-Host "Deploying Log Analytics Workspace & Sentinel..." -ForegroundColor Yellow
az deployment group create `
    --name "Deploy-Sentinel-$(Get-Date -Format 'yyyyMMdd-HHmm')" `
    --resource-group $RG_NAME `
    --template-file $TEMPLATE_PATH

# 2. Get the Workspace ID
$lawId = az monitor log-analytics workspace show --resource-group $RG_NAME --workspace-name $WORKSPACE_NAME --query id -o tsv

# 3. Link Project 1 Resources
Write-Host "Linking Project 1 resources to Watchtower..." -ForegroundColor Cyan

# Corrected Log/Metric syntax for Windows PowerShell
$kvLogs = '[{"category": "AuditEvent","enabled": true}]'
$stMetrics = '[{"category": "AllMetrics","enabled": true}]'

# Link Key Vault
$kvName = (az keyvault list --resource-group $RG_NAME --query "[?contains(name, 'kv-ep')].name" -o tsv)
if ($kvName) {
    Write-Host "Enabling Diagnostic Logs for Key Vault: $kvName" -ForegroundColor Green
    az monitor diagnostic-settings create --name "SentinelStream" --resource $kvName --resource-group $RG_NAME --workspace $lawId --logs $kvLogs
}

# Link Storage Account
$stName = (az storage account list --resource-group $RG_NAME --query "[?contains(name, 'step')].name" -o tsv)
if ($stName) {
    Write-Host "Enabling Diagnostic Logs for Storage: $stName" -ForegroundColor Green
    az monitor diagnostic-settings create --name "SentinelStream" --resource $stName --resource-group $RG_NAME --workspace $lawId --metrics $stMetrics
}

Write-Host "--- Watchtower Deployment & Linking Complete ---" -ForegroundColor Green