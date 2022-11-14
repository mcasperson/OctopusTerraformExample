This repo provides sample Terraform files used to populate new spaces in Octopus and create
small sample projects.

The Terraform projects have a one-to-many relationship with the resources they create. For example,
you would likely create many new spaces with the configuration files under the `space_init`
directory.

To accomplish this, each time the configuration is applied, it must use a unique backend location.
Unfortunately [Terraform does not support variables in the backend configuration](https://github.com/hashicorp/terraform/issues/13022).

To work around this, the backend configuration includes Octopus template syntax to replace the
key in a shared S3 bucket with a variable generated at runtime. This allows one package to manage
multiple resources.