####################
#
# Harness Template Validations
#
####################
locals {
  template_outputs = flatten([
    {
      test                  = true
      relative              = module.template_step_relative.details
      relative_organization = module.template_step_relative_organization.details
      relative_account      = module.template_step_relative_account.details
      absolute              = module.template_step_absolute.details
      yaml_data             = module.template_step_yaml_data_minimal.details
      yaml_data_full        = module.template_step_yaml_data_full.details
    }
  ])
}

module "template_step_relative" {

  source = "../../modules/templates"

  name             = "test-template-step-relative"
  organization_id  = local.organization_id
  project_id       = local.project_id
  template_version = "v1.0.0"
  type             = "Step"
  yaml_file        = "templates/step-template.yaml"
  global_tags      = local.common_tags

}
module "template_step_relative_organization" {

  source = "../../modules/templates"

  name             = "test-template-step-relative-organization"
  organization_id  = local.organization_id
  template_version = "v1.0.0"
  type             = "Step"
  yaml_file        = "templates/step-template.yaml"
  global_tags      = local.common_tags

}
module "template_step_relative_account" {

  source = "../../modules/templates"

  name             = "${local.organization_id}-test-template-step-relative-account"
  template_version = "v1.0.0"
  type             = "Step"
  yaml_file        = "templates/step-template.yaml"
  global_tags      = local.common_tags

}
module "template_step_absolute" {

  source = "../../modules/templates"

  name             = "test-template-step-absolute"
  organization_id  = local.organization_id
  project_id       = local.project_id
  template_version = "v1.0.0"
  type             = "Step"
  yaml_file        = "${path.module}/rendered/templates/step-template.yaml"
  global_tags      = local.common_tags

}
module "template_step_yaml_data_minimal" {

  source = "../../modules/templates"

  name             = "test-template-step-yaml-data-minimal"
  organization_id  = local.organization_id
  project_id       = local.project_id
  template_version = "v1.0.0"
  type             = "Step"
  yaml_data        = <<EOT
  spec:
    type: ShellScript
    timeout: 10m
    spec:
      shell: Bash
      onDelegate: true
      source:
        type: Inline
        spec:
          script: |-
            #!/bin/sh
            set -eou pipefail
            set +x

            echo '
            ------------------------------------------------------
            ---- This is a Test Step ----
            ------------------------------------------------------
            '
      environmentVariables: []
      outputVariables: []
  EOT
  global_tags      = local.common_tags

}
module "template_step_yaml_data_full" {

  source = "../../modules/templates"

  identifier       = "test_template_step_yaml_data_full"
  name             = "test-template-step-yaml-data-full"
  organization_id  = local.organization_id
  project_id       = local.project_id
  template_version = "v1.0.0"
  type             = "Step"
  comments         = "Created"
  yaml_render      = false
  yaml_data        = <<EOT
  template:
    name: test-template-step-yaml-data-full
    identifier: test_template_step_yaml_data_full
    projectIdentifier: ${local.project_id}
    orgIdentifier: ${local.organization_id}
    description: Harness Template created via Terraform
    versionLabel: v1.0.0
    type: Step
    spec:
      type: ShellScript
      timeout: 10m
      spec:
        shell: Bash
        onDelegate: true
        source:
          type: Inline
          spec:
            script: |-
              #!/bin/sh
              set -eou pipefail
              set +x

              echo '
              ------------------------------------------------------
              ---- This is a Test Step ----
              ------------------------------------------------------
              '
        environmentVariables: []
        outputVariables: []
  EOT
  tags = {
    role = "full-yaml-data"
  }
  global_tags = local.common_tags

}
