param location string = resourceGroup().location

resource finOpsIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'id-epiq-finops-helper'
  location: location
}

// Assign 'Reader' role at the Resource Group level so the Identity can scan for orphans
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(finOpsIdentity.id, 'reader')
  scope: resourceGroup()
  properties: {
    principalId: finOpsIdentity.properties.principalId
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
    principalType: 'ServicePrincipal'
  }
}
