data "octopusdeploy_spaces" "spaces" {
  name = var.octopus_space_name
  skip = 5
  take = 100
}