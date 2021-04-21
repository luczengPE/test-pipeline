param KVPrefix string = 'kvtest'
var uniqueKVName = '${KVPrefix}${uniqueString(resourceGroup().id)}'

param objectId string 

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' = {
  location: 'australiasoutheast'
  name: uniqueKVName
  //name: 'templateKVtestDPE123'
  tags: {
    'demo-delete': 'true'
  }
  properties: {
    enabledForDeployment: false
    enabledForDiskEncryption : false
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    //enableRbacAuthorization: true
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: objectId
        permissions: {
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
          certificates: [
            'all'
          ]
          storage: [
            'all'
          ]
        }
      }
      
    ]
    
  }
}

output keyVaultUri string = kv.properties.vaultUri
output keyVaultSkuName string = kv.properties.sku.name
