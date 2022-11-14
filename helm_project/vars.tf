variable "octopus_server" {
  type        = string
  nullable    = "false"
  description = "The URL of the Octopus server e.g. https://myinstance.octopus.app."
}

variable "octopus_apikey" {
  type        = string
  sensitive   = true
  nullable    = false
  description = "The API key used to access the Octopus server. See https://octopus.com/docs/octopus-rest-api/how-to-create-an-api-key for details on creating an API key."
}

variable "octopus_space_id" {
  type        = string
  nullable    = false
  description = "The ID of the space to place the new project in e.g. Spaces-1"
}

variable "octopus_project_group_name" {
  type        = string
  nullable    = false
  description = "The name of the new project group to create."
}

variable "octopus_project_group_description" {
  type        = string
  nullable    = false
  description = "The description of the new project group to create."
}

variable "octopus_project_name" {
  type        = string
  nullable    = false
  description = "The name of the new project to create."
}

variable "octopus_project_description" {
  type        = string
  nullable    = false
  description = "The description of the new project to create."
}

variable "helm_package_id" {
  type        = string
  nullable    = false
  description = "The ID of the helm chart to deploy."
}

variable "helm_release_name" {
  type        = string
  nullable    = false
  description = "The name of the helm release."
}

variable "helm_variables" {
  type        = map(string)
  nullable    = false
  description = "The list of variables to be supplied to the helm chart."
  default     = {}
}

variable "octopus_environments" {
  type = list(string)
  nullable = false
  description = "The list of environments in the space."
  default = ["Development", "Test", "Production"]
}

variable "worker_pool_name" {
  type = string
  nullable = false
  description = "The name of the worker pool to run deployments from"
}