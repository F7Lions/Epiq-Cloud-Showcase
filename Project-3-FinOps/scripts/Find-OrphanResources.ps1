$RG = "rg-epiq-test"
Write-Host "--- Starting Epiq Cloud Cost Audit (CLI Mode) ---" -ForegroundColor Cyan

# 1. Find Unattached Managed Disks
Write-Host "Checking for unattached disks in $RG..." -NoNewline
$orphanedDisks = az disk list -g $RG --query "[?managedBy==null].{Name:name, RG:resourceGroup}" -o json | ConvertFrom-Json
Write-Host " DONE." -ForegroundColor Green

foreach ($disk in $orphanedDisks) {
    Write-Host "[WASTE FOUND] Unattached Disk: $($disk.Name)" -ForegroundColor Yellow
}

# 2. Find Unassociated Public IPs
Write-Host "Checking for unassociated IPs in $RG..." -NoNewline
$orphanedIPs = az network public-ip list -g $RG --query "[?ipConfiguration==null].{Name:name, RG:resourceGroup}" -o json | ConvertFrom-Json
Write-Host " DONE." -ForegroundColor Green

foreach ($ip in $orphanedIPs) {
    Write-Host "[WASTE FOUND] Unassociated IP: $($ip.Name)" -ForegroundColor Yellow
}

if (($null -eq $orphanedDisks -or $orphanedDisks.Count -eq 0) -and ($null -eq $orphanedIPs -or $orphanedIPs.Count -eq 0)) {
    Write-Host "Environment is Optimized! No orphans found." -ForegroundColor Green
}
