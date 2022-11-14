# https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/data-sources/environments
# Loop over each environment and lookup the ID.
data "octopusdeploy_environments" "environment" {
  count = length(var.octopus_environments)
  name  = var.octopus_environments[count.index].name
  skip  = 0
  take  = 1
}