# Epiq Cloud DevOps - Project 1 Cleanup Script
# Client: TBC(To be confirmed)

$RG_NAME = "rg-epiq-test"

Write-Host "--- Starting Cleanup for Project 1 ---" -ForegroundColor Cyan

# 1. Verification Check
$rgExists = az group exists --name $RG_NAME
if ($rgExists -eq "true") {
    Write-Host "⚠️ WARNING: This will permanently delete all resources in $RG_NAME." -ForegroundColor Red
    $confirmation = Read-Host "Are you sure you want to proceed? (y/n)"
    
    if ($confirmation -eq 'y') {
        Write-Host "Deleting Resource Group: $RG_NAME..." -ForegroundColor Yellow
        az group delete --name $RG_NAME --yes --no-wait
        Write-Host "Successfully triggered deletion. Azure is now scrubbing the environment." -ForegroundColor Green
    } else {
        Write-Host "Cleanup cancelled." -ForegroundColor White
    }
} else {
    Write-Host "Resource Group $RG_NAME not found. Nothing to clean up." -ForegroundColor Green
}

Write-Host "--- Cleanup Task Complete ---" -ForegroundColor Cyan