# https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/resources/project_group
# This is the project group that the new project is placed into.
resource "octopusdeploy_project_group" "new_project_group" {
  description = var.octopus_project_group_description
  name        = var.octopus_project_group_name
}

# https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/resources/project
resource "octopusdeploy_project" "new_project" {
  auto_create_release                  = false
  default_guided_failure_mode          = "EnvironmentDefault"
  default_to_skip_if_already_installed = false
  description                          = var.octopus_project_description
  discrete_channel_release             = false
  is_disabled                          = false
  is_discrete_channel_release          = false
  is_version_controlled                = false
  name                                 = var.octopus_project_name
  project_group_id                     = octopusdeploy_project_group.new_project_group.id
  tenanted_deployment_participation    = "Untenanted"
  space_id                             = var.octopus_space_id
  lifecycle_id                         = data.octopusdeploy_lifecycles.default.lifecycles[0].id
  included_library_variable_sets       = []
  versioning_strategy {
    template = "#{Octopus.Version.LastMajor}.#{Octopus.Version.LastMinor}.#{Octopus.Version.LastPatch}.#{Octopus.Version.NextRevision}"
  }

  connectivity_policy {
    allow_deployments_to_no_targets = true
    exclude_unhealthy_targets       = false
    skip_machine_behavior           = "SkipUnavailableMachines"
  }
}

# These are some handy debugging variables you can set to true when performing deployments in Octopus.
# https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/resources/variable
resource "octopusdeploy_variable" "debug_variable" {
  name         = "OctopusPrintVariables"
  type         = "String"
  description  = "A debug variable used to print all variables to the logs. See [here](https://octopus.com/docs/support/debug-problems-with-octopus-variables) for more information."
  is_sensitive = false
  owner_id     = octopusdeploy_project.new_project.id
  value        = "False"
}

# These are some handy debugging variables you can set to true when performing deployments in Octopus.
resource "octopusdeploy_variable" "debug_evaluated_variable" {
  name         = "OctopusPrintEvaluatedVariables"
  type         = "String"
  description  = "A debug variable used to print all variables to the logs. See [here](https://octopus.com/docs/support/debug-problems-with-octopus-variables) for more information."
  is_sensitive = false
  owner_id     = octopusdeploy_project.new_project.id
  value        = "False"
}

# This is the deployment process i.e. the list of steps.
# https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs/resources/deployment_process
resource "octopusdeploy_deployment_process" "new_deployment_process" {
  project_id = octopusdeploy_project.new_project.id

  step {
      condition           = "Success"
      name                = "Deploy Serverless App"
      package_requirement = "LetOctopusDecide"
      start_trigger       = "StartAfterPrevious"
      action {
        action_type    = "Octopus.Script"
        name           = "Deploy Serverless App"
        run_on_server  = true
        worker_pool_id = data.octopusdeploy_worker_pools.kubernetes_worker_pool.worker_pools[0].id

        package {
          name                      = "serverlessapp"
          package_id                = var.serverless_package_id
          feed_id                   = data.octopusdeploy_feeds.built_in.feeds[0].id
          acquisition_location      = "Server"
          extract_during_deployment = true
        }

        properties = {
          "Octopus.Action.RunOnServer" : "true",
          "Octopus.Action.Script.ScriptSource" : "Inline",
          "Octopus.Action.Script.Syntax" : "Bash",
          "Octopus.Action.Script.ScriptBody" : <<EOF
          cd serverlessapp
          serverless deploy 2>&1
          EOF
        }
      }
    }

}