# https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/data-sources/spaces
# Look up the space from the space name. This is used to give us the space ID.
data "octopusdeploy_spaces" "spaces" {
  partial_name = var.octopus_space_name
  skip         = 0
  take         = 1
}