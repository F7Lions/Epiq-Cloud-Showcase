targetScope = 'resourceGroup'

param location string = 'southeastasia'
param prefix string = 'ep'
param env string = 'prd'

// 1. Generate a fresh suffix based on deployment time to bypass soft-delete conflicts
param deploymentTime string = utcNow()
var freshSuffix = substring(uniqueString(resourceGroup().id, deploymentTime), 0, 6)

// 2. Define resource names using the fresh suffix
var vnetName = 'vnet-${prefix}-${env}-${freshSuffix}'
var kvName = 'kv-${prefix}-${env}-${freshSuffix}'
var storageName = 'st${prefix}${env}${freshSuffix}'

// 3. Deploy Modules
module vnet './modules/vnet.bicep' = {
  name: 'vnet-deployment'
  params: {
    location: location
    vnetName: vnetName
  }
}

module keyvault './modules/keyvault.bicep' = {
  name: 'keyvault-deployment'
  params: {
    location: location
    vaultName: kvName
  }
}

module storage './modules/storage.bicep' = {
  name: 'storage-deployment'
  params: {
    location: location
    storageName: storageName
    subnetId: vnet.outputs.appSubnetId 
  }
}

// 4.Outputs for Screenshot Evidence
output vnetId string = vnet.outputs.appSubnetId 
output storageId string = storage.outputs.storageId
output vaultUri string = keyvault.outputs.vaultUri
