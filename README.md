This repo provides sample Terraform files used to populate new spaces in Octopus and create
small sample projects.

The Terraform projects have a one-to-many relationship with the resources they create. For example,
you would likely create many new spaces with the configuration files under the `space_init`
directory.

To accomplish this, each time the configuration is applied, it must use a unique backend location.
Unfortunately [Terraform does not support variables in the backend configuration](https://github.com/hashicorp/terraform/issues/13022).

To work around this, the backend configuration has been defined in a JSON file (as opposed to the HCL
syntax used by other configuration files). This JSON can be modified during deployment using the
[structured configuration variables](https://octopus.com/docs/projects/steps/configuration-features/structured-configuration-variables-feature)
feature to inject unique backend configuration based on the resources being created.