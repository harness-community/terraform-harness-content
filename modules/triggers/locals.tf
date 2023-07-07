####################
#
# Harness Trigger Local Variables
#
####################
locals {
  required_tags = [
    "created_by:Terraform"
  ]
  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries
  global_tags = [for k, v in var.global_tags : "${k}:${v}"]
  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries
  tags = [for k, v in var.tags : "${k}:${v}"]

  common_tags = flatten([
    local.tags,
    local.global_tags,
    local.required_tags
  ])

  auto_identifier = (
        replace(
          replace(
            var.name,
            " ",
            "_"
          ),
          "-",
          "_"
        )
  )

  fmt_identifier = (
    var.identifier == null
    ?
    (
      var.case_sensitive
      ?
      local.auto_identifier
      :
      lower(local.auto_identifier)
    )
    :
    var.identifier
  )

  yaml = (
    var.yaml_file != null
    ?
    try(
      file("${path.module}/rendered/${var.yaml_file}"),
      file("${path.root}/rendered/${var.yaml_file}"),
      file(var.yaml_file)
    )
    :
    var.yaml_data == null
    ?
    "invalid-missing-yaml-details"
    :
    length(var.yaml_data) == 0
    ?
    "invalid-missing-yaml-details"

    :
    var.yaml_data

  )

  yaml_payload = (
    var.yaml_render
    ?
    templatefile(
      "${path.module}/templates/trigger_definition.yml.tpl",
      {
        trigger_name            = var.name
        description             = var.description
        trigger_identifier      = local.fmt_identifier
        organization_identifier = var.organization_id
        project_identifier      = var.project_id
        pipeline_identifier     = var.pipeline_id
        trigger_enabled         = var.trigger_enabled
        yaml_data               = yamlencode(yamldecode(local.yaml))
      }
    )
    :
    local.yaml
  )
}
