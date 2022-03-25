# Demo for Azure Load Testing

Deploys the open source blogging platform Ghost to Azure by publishing a docker container to a Web App.  Web App is secured behind Azure Front Door.  Ghost can only run as a single instance, so Front Door also provides some performance improvements using caching as the Web App can not be scaled out.

Once deployed a load test is run against the Ghost platform to check performance.  In a real world scenario this would likely be done in a deployment slot with the Production and Staging slots switched onced the test has passed.

Azure resources are deployed using Bicep templates based on [@andrewmatveychuk/azure.ghost-web-app-for-containers](https://github.com/andrewmatveychuk/azure.ghost-web-app-for-containers).

The bicep templates have been updated to pass the Front Door ID to the Web settings file to ensure access is restricted to traffic coming through FD only.

Deployment credentials are stored in Secrets.  See https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions on how to create the necessary credentials.

The following secrets are required:
AZURE_CREDENTIALS - See https://docs.microsoft.com/en-us/azure/load-testing/tutorial-cicd-github-actions#set-up-github-access-permissions-for-azure
AZURE_LOAD_TEST_RESOURCE_NAME - Existing Azure Load Test resource.  Assumes it resides in the same resource group as used for deployment.
AZURE_RG - Name of target resource group for deployment
AZURE_SUBSCRIPTION - Azure subscription ID
GHOST_MYSQL_PASSWORD - Admin password for new Ghost database

NOTE: The service prinicipal requires sufficient permissions to deploy the Azure resources in addition to the Load Test Contributor role.  A service principal with Owner or Contributor permissions on the sub or rg will still need the Load Test specific role assignment.

The test config and test plan files can be found in the ./test folder.
testplan.jmx - JMeter script taken from https://docs.microsoft.com/en-us/azure/load-testing/quickstart-create-and-run-load-test
testconfig.yml - See https://docs.microsoft.com/en-us/azure/load-testing/reference-test-config-yaml for format.  This file can be downloaded from the portal once a test has been manually run by selecting Download>Input File in the Test Run detail screen.

The Ghost Docker image used is from [@keyoke/docker-ghost-ai](https://github.com/keyoke/docker-ghost-ai) implementation to demonstrate instrumentation for Application Insights.

The official Ghost code repo [@TryGhost/ghost](https://github.com/TryGhost/Ghost) should be used to obtain source files for customisation and deployment of the production application.

#
#
