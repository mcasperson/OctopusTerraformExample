resource "octopusdeploy_static_worker_pool" "new_pool" {
  description = "The worker pool hosting tentacles deployed to the k8s cluster"
  is_default  = true
  name        = "Kubernetes Workers"
  sort_order  = 5
}