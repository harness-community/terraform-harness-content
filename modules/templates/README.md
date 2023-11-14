# Terraform Modules for Harness Templates
Terraform Module for creating and managing Harness Templates

## Summary
This module handle the creation and managment of templates by leveraging the Harness Terraform provider

## Supported Terraform Versions
_Note: These modules require a minimum of Terraform Version 1.2.0 to support the Input Validations and Precondition Lifecycle hooks leveraged in the code._

_Note: The list of supported Terraform Versions is based on the most recent of each release which has been tested against this module._

    - v1.2.9
    - v1.3.9
    - v1.4.6
    - v1.5.7
    - v1.6.0
    - v1.6.1
    - v1.6.2
    - v1.6.3


_Note: Terraform version 1.4.1 will not work due to an issue with the Random provider_

## Providers

```
terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.14"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
  }
}

```

## Variables

_Note: When the identifier variable is not provided, the module will automatically format the identifier based on the provided resource name and the identifier will be in lowercase format with all spaces and hyphens replaced with '\_'. To override the case lowering, you must set the parameter `case_sensitive: true`_

| Name | Description | Type | Default Value | Mandatory |
| --- | --- | --- | --- | --- |
| name | [Required] Provide a resource name. Must be at least 1 character but but less than 128 characters | string | | X |
| identifier | [Optional] Provide a custom identifier.  Must be at least 1 character but but less than 128 characters and can only include alphanumeric or '_' | string | null | |
| template_version | [Required] Version Label for Template. | string |  | X |
| type | [Required] (String) Type of Template. Valid types are: Step, Stage, Pipeline, CustomDeployment, MonitoredService, SecretManager, ArtifactSource, or StepGroup | string |  | X |
| organization_id | [Optional] Provide an organization reference ID. Must exist before execution | string | null | |
| project_id | [Optional] Provide an project reference ID. Must exist before execution | string | null | |
| comments | [Optional] (String) Specify comment with respect to changes. | string | Changes to Template managed by Terraform | |
| yaml_file | [Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with var.yaml_data.| string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_data | [Optional] (String) Description of the resource. | string | null | One of `yaml_file` or `yaml_data` must be provided. |
| yaml_render | [Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file | bool | true | |
| is_stable | [Optional] (Boolean) If true, given version for Template to be set as stable. | bool | true | |
| case_sensitive | [Optional] Should identifiers be case sensitive by default? (Note: Setting this value to `true` will retain the case sensitivity of the identifier) | bool | false | |
| tags | [Optional] Provide a Map of Tags to associate with the project | map(any) | {} | |
| global_tags | [Optional] Provide a Map of Tags to associate with the project and resources created | map(any) | {} | |

## Outputs
| Name | Description | Value |
| --- | --- | --- |
| details | Details for the created Harness Template | Map containing details of created template
| template_details | [Deprecated] Details for the created Harness Template | Map containing details of created template

## Examples
### Build a simple Step Template with minimal inputs using rendered payload
```
module "templates" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/templates"

  name             = "test-step-template"
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
  template_version = "v1.0.0"
  type             = "Step"
  tags             = {
    role = "sample-step"
  }

}
```
### Build a simple Step Template with full step yaml from file
```
module "templates" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/templates"

  name             = "test-step-template"
  organization_id  = "myorg"
  project_id       = "myproject"
  yaml_render      = false
  yaml_file        = "templates/example-step-template.yaml"
  template_version = "v1.0.0"
  type             = "Step"
  tags             = {
    role = "sample-step"
  }

}
```

### Build multiple Templates
```
variable "template_list" {
    type = list(map())
    default = [
        {
            name = "data-parser"
            yaml_file = "templates/step/data-parser.yaml"
            tags = {
                role = "data"
            }
        },
        {
            name = "docker-image-builder"
            description = "Custom docker build script step"
            yaml_file = "templates/step/docker-image-builder.yaml"
            template_version = "v0.5.2"
            tags = {
                role = "docker"
            }
        },
        {
            name = "stage-docker-image-factory"
            description = "Custom Stage Template for standardized Docker Image Factory"
            type = "Stage"
            yaml_file = "templates/stage/docker-image-factory.yaml"
            tags = {
                role = "image-factory"
            }
        }
    ]
}

variable "global_tags" {
    type = map()
    default = {
        environment = "NonProd"
    }
}

module "templates" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/templates"
  for_each = { for template in var.template_list : template.name => template }

  name             = each.value.name
  description      = lookup(each.value, "description", "Step Script for ${each.value.name}")
  template_version = lookup(each.value, "version", "v1.0.0")
  type             = lookup(each.value, "type", "Step")
  yaml_render      = lookup(each.value, "render", true)
  yaml_file        = each.value.yaml_file
  tags             = each.value.tags
  global_tags      = var.global_tags
}
```

## Contributing
A complete [Contributors Guide](../../CONTRIBUTING.md) can be found in this repository

## Authors
Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../../LICENSE) for full details.
