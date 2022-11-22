resource "octopusdeploy_user_role" "deployment_viewer" {
  can_be_deleted             = true
  description                = "Ability to view a deployment."
  granted_space_permissions  = ["DeploymentView"]
  name                       = "Deployment Viewer"
  space_permission_descriptions = []
}

resource "octopusdeploy_user_role" "environment_viewer" {
  can_be_deleted             = true
  description                = "Ability to view enviornments."
  granted_space_permissions  = ["EnvironmentView"]
  name                       = "Environment Viewer"
  space_permission_descriptions = []
}

resource "octopusdeploy_team" "viewers" {
  name                       = "Viewers"
  description                = "Members of this team can view a space."
  can_be_deleted = true
  can_be_renamed = true
  can_change_members = true
  can_change_roles = true
  user_role {
    user_role_id = octopusdeploy_user_role.deployment_viewer.id
  }
  user_role {
    user_role_id = octopusdeploy_user_role.environment_viewer.id
  }
}