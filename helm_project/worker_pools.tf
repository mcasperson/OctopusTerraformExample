# https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/data-sources/worker_pools
# Get the id of the provided worker pool called "Hosted Ubuntu"
data "octopusdeploy_worker_pools" "ubuntu_worker_pool" {
  partial_name = "Hosted Ubuntu"
  take = 1
}

# https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/data-sources/worker_pools
# Get the id of the provided worker pool called "Hosted Windows"
data "octopusdeploy_worker_pools" "windows_worker_pool" {
  partial_name = "Hosted Windows"
  take = 1
}