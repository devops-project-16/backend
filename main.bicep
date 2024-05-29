@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of the App Service plan.')
param serverFarmName string

@description('Name of the first web app.')
param webAppName1 string

@description('Name of the container image.')
param containerImageName string

@description('Name of the container registry.')
param containerRegistryName string

// Get the container registry details
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2019-05-01' existing = {
  name: containerRegistryName
}

var containerRegistryLoginServer = containerRegistry.properties.loginServer
var containerImageFullName = '${containerRegistryLoginServer}/${containerImageName}:44'

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: serverFarmName
  location: location
  sku: {
    name: 'B1'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

// Web App 1
resource webApp1 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName1
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|${containerImageFullName}'
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://${containerRegistryLoginServer}'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: listCredentials(containerRegistry.id, '2019-05-01').username
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: listCredentials(containerRegistry.id, '2019-05-01').passwords[0].value
        }
      ]
    }
  }
}

// Outputs
output registryAdminUsername string = listCredentials(containerRegistry.id, '2019-05-01').username
output registryAdminPassword string = listCredentials(containerRegistry.id, '2019-05-01').passwords[0].value


//az bicep build --file (main.bicep file path)
//az deployment group create --resource-group ProjectResourceroup --template-file (built main.json file path) --parameters (main.parameters.json file path)
