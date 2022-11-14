data "octopusdeploy_spaces" "spaces" {
  partial_name = var.octopus_space_name
  skip         = 5
  take         = 100
}