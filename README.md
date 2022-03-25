# Demo for Azure Load Testing

Azure resources are deployed using Bicep templates based on [@andrewmatveychuk/azure.ghost-web-app-for-containers](https://github.com/andrewmatveychuk/azure.ghost-web-app-for-containers).

MENTION FD-ID change

Deployment credentials are stored in Secrets.  See https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions on how to create the necessary credentials.

The Ghost Docker image used is from [@keyoke/docker-ghost-ai](https://github.com/keyoke/docker-ghost-ai) implementation to demonstrate instrumentation for Application Insights.

The official Ghost code repo [@TryGhost/ghost](https://github.com/TryGhost/Ghost) should be used to obtain source files for customisation and deployment of the production application.

#
#
