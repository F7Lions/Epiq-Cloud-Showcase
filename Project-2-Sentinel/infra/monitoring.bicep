targetScope = 'resourceGroup'
param location string = 'southeastasia'
param workspaceName string = 'law-epiq-watchtower'

// Log Analytics Workspace (The Brain)
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 30
  }
}

// Enable Microsoft Sentinel
resource sentinel 'Microsoft.SecurityInsights/onboardingStates@2023-02-01-preview' = {
  scope: logAnalytics
  name: 'default'
}

output workspaceId string = logAnalytics.id
