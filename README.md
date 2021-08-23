# Ghost PoC for Drone Shuttles

This is a limited PoC for the creation of the new website for Drone Shuttles Ltd using the Ghost blogging platform ([link to Ghost](ghost.org)).

The PoC has the following limitations

* No automation account for scaling the MySQL database
* No backup configuration
* Azure Defender not activated
* No additional security measures such as restricting network access to MySQL and Azure Files
* No deployment slots for the non-production environments
* No Function App for the Delete All Posts functionality
* No approvals on deployment by GitHub Actions
* Deployment is triggered by changes to any file within the repo

Azure resources are deployed using Bicep templates based on [@andrewmatveychuk/azure.ghost-web-app-for-containers](https://github.com/andrewmatveychuk/azure.ghost-web-app-for-containers).

Deployment credentials are stored in Secrets.  See https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions on how to create the necessary credentials.

The Ghost Docker image used is from [@keyoke/docker-ghost-ai](https://github.com/keyoke/docker-ghost-ai) implementation to demonstrate instrumentation for Application Insights.

The official Ghost code repo [@TryGhost/ghost](https://github.com/TryGhost/Ghost) should be used to obtain source files for customisation and deployment of the production application.

