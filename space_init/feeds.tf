# https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/resources/docker_container_registry
# Create a feed for Docker Hub. Note that Docker Hub feeds require credentials to perform image
# lookups.
resource "octopusdeploy_docker_container_registry" "dockerhub_feed" {
  feed_uri = "https://index.docker.io"
  name     = "Docker Hub"
  password = var.docker_hub_password
  username = var.docker_hub_username
}