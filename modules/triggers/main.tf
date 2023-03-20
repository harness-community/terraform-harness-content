####################
#
# Harness Triggers Setup
#
####################
resource "harness_platform_triggers" "trigger" {
  lifecycle {
    precondition {
      condition     = local.yaml != "invalid-missing-yaml-details"
      error_message = "[Invalid] One of the following must be provided - 'yaml_data' or 'yaml_file'"
    }
  }
  # [Required] (String) Unique identifier of the resource.
  identifier = local.fmt_identifier
  # [Required] (String) Name of the resource.
  name = var.name
  # [Required] (String) Unique identifier of the organization.
  org_id = var.organization_id
  # [Required] (String) Unique identifier of the project.
  project_id = var.project_id

  # [Required] Identifier of the target pipeline
  target_id = var.pipeline_id

  # [Required] (String) YAML of the pipeline.
  yaml = local.yaml_payload

  # [Optional] (String) Description of the resource.
  description = var.description
  # [Optional] (see below for nested schema)
  # (Block List, Max: 1) Contains parameters related to creating an Entity for Git Experience.
  # git_details = var.git_details
  # [Optional] (Set of String) Tags to associate with the resource.
  tags = local.common_tags
}

# When creating a new resource, there is a potential race-condition
# as the resource comes up.  This resource will introduce
# a slight delay in further execution to wait for the resources to
# complete.
resource "time_sleep" "trigger_setup" {
  depends_on = [
    harness_platform_triggers.trigger
  ]

  create_duration  = "30s"
  destroy_duration = "15s"
}
