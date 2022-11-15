This repo provides sample Terraform files used to populate new spaces in Octopus and create
small sample projects. The purpose of these Terraform projects is to demonstrate how many resources
in Octopus can be created and managed programmatically from a single source of truth following DRY 
principals.

# Project Details

There are five Terraform projects that make up this sample, each in their own subdirectory:

* space_lookup
* space_create
* space_init
* serverless_project
* helm_project

## The space_lookup project

This project does not create any resources. It exists to perform a lookup of a space ID from a name. 
This is done with the [octopusdeploy_spaces](https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/data-sources/spaces)
data resource.

The space ID is captured as an [output variable](https://octopus.com/docs/projects/variables/output-variables)
and consumed by subsequent steps.

## The space_create project

This project creates a new space in Octopus and captures the new space ID as an output variable.
The space ID is then consumed by the `space_init` project.

## The space_init project

This project adds environments, feeds, and worker pools to the space created by the `space_create`
project.

The creation of a new space is a separate process from its initialisation because the `octopusdeploy`
provider requires a space ID, which is only known once the space is created by the `space_create`
project.

## The serverless_project project

This project creates a new project group and project to perform a deployment of a [Serverless 
Framework](https://www.serverless.com/) app. This is implemented as a simple script step that relies
on the worker having already established IAM credentials.

## The helm_project project

This project creates a new project group and project to perform a Helm chart deployment. This is
implemented with the `Upgrade a Helm Chart` step.

To establish the Kubernetes context, the first step of this deployment process creates a new
Kubernetes target using [dynamic infrastructure](https://octopus.com/docs/infrastructure/deployment-targets/dynamic-infrastructure) 
scripts. These scripts assume the worker that the deployment is being run on has a Kubernetes
service account token exposed.

## A note on backend storage
The Terraform projects have a one-to-many relationship with the resources they create. For example,
you would likely create many new spaces with the configuration files under the `space_init`
directory, and many new projects with the configuration files under `helm_project`.

To accomplish this, each time the configuration is applied, it must use a unique backend location.
Unfortunately [Terraform does not support variables in the backend configuration](https://github.com/hashicorp/terraform/issues/13022).

To work around this, the backend configuration includes Octopus template syntax to replace the
key in a shared S3 bucket with a variable generated at runtime. This allows one package to manage
multiple resources.

# Creating Kubernetes workers

The `Dockerfile` under the `docker` directory creates a new Docker image running a polling tentacle
in a Kubernetes cluster. It installs a number of common dependencies and utilities required to execute deployments,
as well as specialised tools like `serverless` and `helm`.

The image created by this `Dockerfile` is then deployed via the Deployment resource the `k8s` directory.

For conveninece this Docker image has been built and published to DockerHub as 
[octopussamples/flightcentretentacle](https://hub.docker.com/r/octopussamples/flightcentretentacle).

# Viewing the devops runbooks in Octopus.

A public, readonly Octopus instance [here](https://mattc.octopus.app/app#/Spaces-1313/projects/create-new-space/operations/runbooks)
demonstrates how the Terraform projects are executed.

A sample space called [Bookings](https://mattc.octopus.app/app#/Spaces-1318) shows the end result
of the Terraform projects creating a new space and deploying two new projects.