variable "octopus_server" {
  type        = string
  nullable    = "false"
  description = "The URL of the Octopus server e.g. https://myinstance.octopus.app."
}

variable "octopus_apikey" {
  type      = string
  sensitive = true
  nullable  = false
  description = "The API key used to access the Octopus server. See https://octopus.com/docs/octopus-rest-api/how-to-create-an-api-key for details on creating an API key."
}

variable "octopus_space_id" {
  type      = string
  sensitive = true
  nullable  = false
  description = "The ID of the newly created space."
}

variable "docker_hub_username" {
  type      = string
  nullable  = false
  description = "The DockerHub username."
}

variable "docker_hub_password" {
  type      = string
  sensitive = true
  nullable  = false
  description = "The DockerHub password."
}

variable "octopus_environments" {
  type = list(object({
    name = string
    description = string
  }))
  nullable = false
  description = "The list of environments to create in the new space."
  default = [
    {
      name = "Development"
      description = "The development environment"
    },
    {
      name = "Test"
      description = "The test environment"
    },
    {
      name = "Production"
      description = "The production environment"
    }
  ]
}