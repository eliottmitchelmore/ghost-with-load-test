targetScope = 'resourceGroup'

param webAppName string

param fdId string

@allowed([
  'Web app with Azure CDN'
  'Web app with Azure Front Door'
])
param deploymentConfiguration string

param applicationInsightsInstrumentationKey string

param applicationInsightsConnectionString string

@description('MySQL server hostname')
param databaseHostFQDN string

@description('Ghost datbase name')
param databaseName string

@description('Ghost database user name')
param databaseLogin string

@description('Ghost database user password')
param databasePasswordSecretUri string

@description('Website URL to autogenerate links by Ghost')
param siteUrl string

@description('Mount path for Ghost content files')
param containerMountPath string

@description('Container registry to pull Ghost docker image')
param containerRegistryUrl string

resource existingWebApp 'Microsoft.Web/sites@2020-09-01' existing = {
  name: webAppName
}

resource webAppSettings 'Microsoft.Web/sites/config@2021-01-15' = {
  parent: existingWebApp
  name: 'appsettings'
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: applicationInsightsInstrumentationKey
    APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsightsConnectionString
    ApplicationInsightsAgent_EXTENSION_VERSION: '~2'
    XDT_MicrosoftApplicationInsights_Mode: 'default'
    WEBSITES_ENABLE_APP_SERVICE_STORAGE: 'false'
    DOCKER_REGISTRY_SERVER_URL: containerRegistryUrl
    // Ghost-specific settings
    NODE_ENV: 'production'
    GHOST_CONTENT: containerMountPath
    paths__contentPath: containerMountPath
    privacy_useUpdateCheck: 'false'
    url: siteUrl
    database__client: 'mysql'
    database__connection__host: databaseHostFQDN
    database__connection__user: databaseLogin
    database__connection__password: '@Microsoft.KeyVault(SecretUri=${databasePasswordSecretUri})'
    database__connection__database: databaseName
    database__connection__ssl: 'true'
    database__connection__ssl_minVersion: 'TLSv1.2'
  }
}

resource siteConfig 'Microsoft.Web/sites/config@2021-01-15' = if (deploymentConfiguration == 'Web app with Azure Front Door') {
  parent: existingWebApp
  name: 'web'
  properties: {
    ipSecurityRestrictions: [
      {
        ipAddress: 'AzureFrontDoor.Backend'
        action: 'Allow'
        tag: 'ServiceTag'
        priority: 300
        name: 'Access from Azure Front Door'
        description: 'Rule for access from Azure Front Door'
        headers: {
          'x-azure-fdid': [
            fdId
          ]
        }
      }
    ]
  }
}
