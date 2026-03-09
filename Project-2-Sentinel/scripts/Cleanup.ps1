# Project 2 Cleanup Script
$ResourceGroupName = "rg-epiq-test"

Write-Host "Starting Cleanup for Project 2: Sentinel Watchtower..." -ForegroundColor Cyan

# 1. Remove the Diagnostic Setting from the Key Vault first
Write-Host "Removing Key Vault Diagnostic Settings..."
$kv = Get-AzKeyVault -ResourceGroupName $ResourceGroupName -VaultName "kv-ep-prd-vfrlat"
Remove-AzDiagnosticSetting -Name "RouteToSentinel" -ResourceId $kv.ResourceId

# 2. Delete the Watchtower resources (LAW, Alert, Workbook)
# We delete individual resources to avoid deleting the entire Resource Group if it contains Project 1 work.
Write-Host "Deleting Log Analytics Workspace and Sentinel..."
Remove-AzOperationalInsightsWorkspace -ResourceGroupName $ResourceGroupName -Name "law-epiq-watchtower" -Force

Write-Host "Cleanup Complete! Project 2 resources have been decommissioned." -ForegroundColor Green