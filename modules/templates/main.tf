####################
#
# Harness Template Setup
#
####################
resource "harness_platform_template" "templates" {
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
  # [Optional] (String) Unique identifier of the organization.
  org_id = var.organization_id
  # [Optional] (String) Unique identifier of the project.
  project_id = var.project_id
  # [Required] (String) YAML of the pipeline.
  template_yaml = local.yaml_payload

  # [Optional] (String) Description of the resource.
  # description = var.description
  # [Optional] (String) Comments with respect to changes.
  comments = var.comments
  # [Optional] (String) Version Label for Template.
  version = var.template_version
  # [Optional] (Bool) If true, given version for template to be set as stable.
  is_stable = var.is_stable
  # [Optional] (see below for nested schema)
  # (Block List, Max: 1) Contains parameters related to creating an Entity for Git Experience.
  # git_details = var.git_details
  # [Optional] (Set of String) Tags to associate with the resource.
  tags = local.common_tags_tuple
}

# When creating a new Template, there is a potential race-condition
# as the template comes up. This resource will introduce
# a slight delay in further execution to wait for the resources to
# complete.
resource "time_sleep" "template_setup" {
  depends_on = [
    harness_platform_template.templates
  ]

  create_duration  = "15s"
  destroy_duration = "5s"
}
