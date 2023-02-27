# Format Organization Test outputs
module "pipelines_file_relative" {

  source = "../../pipelines"

  name            = "test-pipeline-relative"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_file       = "pipelines/ci-pipeline-demo.yaml"
  global_tags     = local.common_tags

}

module "pipelines_file_absolute" {

  source = "../../pipelines"

  name            = "test-pipeline-absolute"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_file       = "${path.module}/rendered/pipelines/ci-pipeline-demo.yaml"
  global_tags     = local.common_tags

}

module "pipelines_file_yaml_data_minimal" {

  source = "../../pipelines"

  name            = "test-pipeline-yaml-data-minimal"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_data       = <<EOT
  stages:
    - stage:
        name: Build
        identifier: Build
        description: ""
        type: CI
        spec:
          cloneCodebase: false
          infrastructure:
            type: KubernetesDirect
            spec:
              connectorRef: account.harnessworkloadaks
              namespace: demolab
              automountServiceAccountToken: true
              nodeSelector: {}
              os: Linux
          execution:
            steps:
              - step:
                  type: Run
                  name: WhoAmI
                  identifier: WhoAmI
                  spec:
                    connectorRef: account.harnessImage
                    image: busybox
                    shell: Sh
                    command: whoami
  EOT
  global_tags     = local.common_tags

}

module "pipelines_file_yaml_data_full" {

  source = "../../pipelines"

  name            = "test-pipeline-yaml-data-full"
  organization_id = local.organization_id
  project_id      = local.project_id
  yaml_render     = false
  yaml_data       = <<EOT
  pipeline:
    name: test-pipeline-yaml-data-full
    identifier: test_pipeline_yaml_data_full
    projectIdentifier: ${local.project_id}
    orgIdentifier: ${local.organization_id}
    description: Harness Pipeline created via Terraform
    stages:
      - stage:
          description: ""
          identifier: Build
          name: Build
          spec:
            cloneCodebase: false
            execution:
              steps:
                - step:
                    identifier: WhoAmI
                    name: WhoAmI
                    spec:
                      command: whoami
                      connectorRef: account.harnessImage
                      image: busybox
                      shell: Sh
                    type: Run
            infrastructure:
              spec:
                automountServiceAccountToken: true
                connectorRef: account.harnessworkloadaks
                namespace: demolab
                nodeSelector: {}
                os: Linux
              type: KubernetesDirect
          type: CI

  EOT
  global_tags     = local.common_tags

}
