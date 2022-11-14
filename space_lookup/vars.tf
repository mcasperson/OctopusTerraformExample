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

variable "octopus_space_name" {
  type        = string
  nullable    = "false"
  description = "The name of the space to return the ID for."
}