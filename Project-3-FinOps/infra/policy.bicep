targetScope = 'subscription'

resource taggingPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'add-security-review-tag'
  properties: {
    displayName: 'Add Security-Review-Date Tag'
    policyType: 'Custom'
    mode: 'Indexed'
    policyRule: {
      if: {
        field: 'tags[Security-Review-Date]'
        exists: 'false'
      }
      then: {
        effect: 'append'
        details: [
          {
            field: 'tags[Security-Review-Date]'
            value: '[utcNow()]'
          }
        ]
      }
    }
  }
}
