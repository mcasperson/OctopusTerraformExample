# https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/data-sources/feeds
# Get the ID of the feed called "Docker Hub".
data "octopusdeploy_feeds" "dockerhub" {
  feed_type    = "Docker"
  partial_name = "Docker Hub"
  skip         = 0
  take         = 1
}

# Get the ID of the built-in feed for the current space.
data "octopusdeploy_feeds" "built_in" {
  feed_type = "BuiltIn"
  skip      = 0
  take      = 1
}

# Get the ID of the feed hosting the helm chart
data "octopusdeploy_feeds" "helm_feed" {
  feed_type    = "Helm"
  partial_name = var.helm_feed_name
  skip         = 0
  take         = 1
}