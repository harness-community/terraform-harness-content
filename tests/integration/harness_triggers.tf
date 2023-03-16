####################
#
# Harness Trigger Validations
#
####################

locals {
  trigger_outputs = flatten([
    {
      test             = true
      minimum          = module.triggers_minimal.details
      trigger_disabled = module.triggers_disabled.details
      yaml_data        = module.triggers_yaml_data.details
      yaml_data_full   = module.triggers_yaml_data_full.details
    }
  ])
}

module "pipeline_triggers" {
  source = "../../modules/pipelines"

  name            = "test-trigger-pipeline"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_file       = "pipelines/ci-pipeline-demo.yaml"
  global_tags     = local.common_tags

}

module "triggers_minimal" {
  source = "../../modules/triggers"

  name            = "test-trigger-minimal"
  organization_id = local.organization_id
  project_id      = local.project_id
  pipeline_id     = module.pipeline_triggers.details.id
  yaml_file       = "triggers/basic-trigger-example.yaml"
}

module "triggers_disabled" {
  source = "../../modules/triggers"

  name            = "test-trigger-disabled"
  organization_id = local.organization_id
  project_id      = local.project_id
  pipeline_id     = module.pipeline_triggers.details.id
  trigger_enabled = false
  yaml_file       = "triggers/basic-trigger-example.yaml"
}

module "triggers_yaml_data" {
  source = "../../modules/triggers"

  name            = "test-trigger-yaml-data"
  organization_id = local.organization_id
  project_id      = local.project_id
  pipeline_id     = module.pipeline_triggers.details.id
  yaml_data       = <<EOT
  source:
    type: "Webhook"
    spec:
      type: "Github"
      spec:
        type: "Push"
        spec:
          connectorRef: "account.TestAccResourceConnectorGithub_Ssh_IZBeG"
          autoAbortPreviousExecutions: false
          payloadConditions:
          - key: "changedFiles"
            operator: "Equals"
            value: "value"
          - key: "targetBranch"
            operator: "Equals"
            value: "value"
          headerConditions: []
          repoName: "repoName"
          actions: []
  inputYaml: "pipeline: {}\n"

  EOT
}

module "triggers_yaml_data_full" {
  source = "../../modules/triggers"

  name            = "test-trigger-yaml-data-full"
  organization_id = local.organization_id
  project_id      = local.project_id
  pipeline_id     = module.pipeline_triggers.details.id
  yaml_render     = false
  yaml_data       = <<EOT
  trigger:
    name: test-trigger-yaml-data-full
    identifier: test_trigger_yaml_data_full
    orgIdentifier: ${local.organization_id}
    projectIdentifier: ${local.project_id}
    pipelineIdentifier: ${module.pipeline_triggers.details.id}
    description: Harness Pipeline created via Terraform
    source:
      type: "Webhook"
      spec:
        type: "Github"
        spec:
          type: "Push"
          spec:
            connectorRef: "account.TestAccResourceConnectorGithub_Ssh_IZBeG"
            autoAbortPreviousExecutions: false
            payloadConditions:
            - key: "changedFiles"
              operator: "Equals"
              value: "value"
            - key: "targetBranch"
              operator: "Equals"
              value: "value"
            headerConditions: []
            repoName: "repoName"
            actions: []
    inputYaml: "pipeline: {}\n"

  EOT
}
