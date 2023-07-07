####################
#
# Harness InputSet Validations
#
####################

locals {
  input_set_outputs = flatten([
    {
      test           = true
      minimum        = module.input_sets_minimal.details
      yaml_data      = module.input_sets_yaml_data.details
      yaml_data_full = module.input_sets_yaml_data_full.details
    }
  ])
}

module "pipeline_input_sets" {
  source = "../../modules/pipelines"

  name            = "test-input-set-pipeline"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_file       = "pipelines/ci-pipeline-demo.yaml"
  global_tags     = local.common_tags

}

module "pipeline_input_sets_case_sensitive" {
  source = "../../modules/pipelines"

  name            = "Test Input Set Pipeline CaseSensitive"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_file       = "pipelines/ci-pipeline-demo.yaml"
  global_tags     = local.common_tags
  case_sensitive  = true

}

module "input_sets_minimal" {
  source = "../../modules/input_sets"

  name            = "test-input-set-minimal"
  organization_id = local.organization_id
  project_id      = local.project_id
  pipeline_id     = module.pipeline_input_sets.details.id
  yaml_file       = "input_sets/basic-input-set-example.yaml"
}

module "input_sets_yaml_data" {
  source = "../../modules/input_sets"

  name            = "test-input-set-yaml-data"
  organization_id = local.organization_id
  project_id      = local.project_id
  pipeline_id     = module.pipeline_input_sets.details.id
  yaml_data       = <<EOT
  variables:
    - name: myvar
      value: success

  EOT
}

module "input_sets_yaml_data_full" {
  source = "../../modules/input_sets"

  name            = "test-input-set-yaml-data-full"
  organization_id = local.organization_id
  project_id      = local.project_id
  pipeline_id     = module.pipeline_input_sets.details.id
  yaml_render     = false
  yaml_data       = <<EOT
  inputSet:
    name: test-input-set-yaml-data-full
    identifier: test_input_set_yaml_data_full
    orgIdentifier: ${local.organization_id}
    projectIdentifier: ${local.project_id}
    description: Harness Input Set created via Terraform
    pipeline:
      identifier: ${module.pipeline_input_sets.details.id}
      variables:
        - name: myvar
          value: success

  EOT
}
