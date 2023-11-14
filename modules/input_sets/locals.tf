####################
#
# Harness Input Sets Local Variables
#
####################
locals {
  required_tags = {
    created_by: "Terraform"
  }

  common_tags = merge(
    var.tags,
    var.global_tags,
    local.required_tags
  )
  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

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
      "${path.module}/templates/input_set_definition.yml.tpl",
      {
        input_set_name          = var.name
        description             = var.description
        input_set_identifier    = local.fmt_identifier
        organization_identifier = var.organization_id
        project_identifier      = var.project_id
        pipeline_identifier     = var.pipeline_id
        yaml_data               = yamlencode(yamldecode(local.yaml))
        tags                    = yamlencode(local.common_tags)
      }
    )
    :
    local.yaml
  )
}
