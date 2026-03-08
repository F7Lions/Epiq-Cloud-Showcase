@description('The name of the Key Vault')
param vaultName string

@description('The location for the Key Vault - strictly Singapore')
param location string = 'southeastasia'

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: vaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true 
    enabledForDiskEncryption: true 
    enableSoftDelete: true
    // REMOVED: softDeleteRetentionInDays to avoid 'BadRequest' conflict
    enablePurgeProtection: true 
    publicNetworkAccess: 'Disabled' 
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  }
}

output vaultUri string = keyVault.properties.vaultUri
output vaultId string = keyVault.id
