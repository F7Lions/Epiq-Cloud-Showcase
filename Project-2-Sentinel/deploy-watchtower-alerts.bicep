param location string = resourceGroup().location
param workspaceId string

resource globalAdminAlert 'Microsoft.Insights/scheduledQueryRules@2022-06-15' = {
  name: 'alert-global-admin-assignment'
  location: location
  properties: {
    displayName: 'IM8: Global Administrator Role Assigned'
    description: 'Detects when a user is assigned the Global Administrator role in Entra ID.'
    severity: 0
    enabled: true
    evaluationFrequency: 'PT15M'
    windowSize: 'PT15M'
    scopes: [workspaceId]
    targetResourceTypes: ['Microsoft.OperationalInsights/workspaces']
    criteria: {
      allOf: [
        {
          query: '''
            AuditLogs
            | where OperationName == "Add member to role"
            | mv-expand TargetResources
            | mv-expand TargetResources.modifiedProperties
            | where TargetResources_modifiedProperties.newValue contains "Global Administrator"
          '''
          timeAggregation: 'Count'
          operator: 'GreaterThan'
          threshold: 0
          failingPeriods: {
            numberOfEvaluationPeriods: 1
            minFailingPeriodsToAlert: 1
          }
        }
      ]
    }
  }
}

resource im8Workbook 'Microsoft.Insights/workbooks@2022-04-01' = {
  name: guid('im8-disk-encryption-dashboard', resourceGroup().id)
  location: location
  kind: 'shared'
  properties: {
    displayName: 'IM8 Compliance: Disk Encryption Status'
    serializedData: '''
      {
        "version": "Notebook/1.0",
        "items": [
          {
            "type": 1,
            "content": {
              "json": "## IM8 Disk Encryption Watchtower\nThis dashboard monitors all virtual machines to ensure OS and Data disks are encrypted per IM8 guidelines."
            }
          },
          {
            "type": 3,
            "content": {
              "version": "KqlItem/1.0",
              "query": "Resources | where type =~ 'microsoft.compute/virtualmachines' | project name, location, encryption = properties.storageProfile.osDisk.managedDisk.securityProfile.securityType | order by name asc",
              "size": 0,
              "queryType": 1,
              "resourceType": "microsoft.resourcegraph/resources"
            }
          }
        ],
        "isLocked": false
      }
    '''
    category: 'workbook'
    sourceId: workspaceId
  }
}