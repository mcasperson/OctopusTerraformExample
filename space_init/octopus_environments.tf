# Loop over all the environments defined in the octopus_environments variable and create a new
# octopus environment resource.
resource "octopusdeploy_environment" "new_environment" {
  count                        = length(var.octopus_environments)
  allow_dynamic_infrastructure = true
  description                  = var.octopus_environments[count.index].description
  name                         = var.octopus_environments[count.index].name
  use_guided_failure           = false
}