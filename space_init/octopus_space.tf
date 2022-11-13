resource "octopusdeploy_space" "new_space" {
  description                 = var.octopus_space_description
  name                        = var.octopus_space_name
  is_default                  = false
  is_task_queue_stopped       = false
  space_managers_teams        = ["teams-managers"]
  space_managers_team_members = []
}

output "octopus_space_id" {
  value = octopusdeploy_space.new_space.id
}