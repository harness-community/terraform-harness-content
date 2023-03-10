# Terraform Modules for Harness Pipelines
Terraform Module for creating and managing Harness Pipelines

## Summary
This module handle the creation and managment of pipelines by leveraging the Harness Terraform provider

## Providers

```
terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}
```

## Variables

_Note: When the identifier variable is not provided, the module will automatically format the identifier based on the provided resource name_

| Name | Description | Type | Default Value | Mandatory |
| --- | --- | --- | --- | --- |
| name | [Required] Provide an organization name.  Must be two or more characters | string | | X |
| organization_id | [Required] Provide an organization reference ID.  Must exist before execution | string | | X |
| identifier | [Optional] Provide a custom identifier.  More than 2 but less than 128 characters and can only include alphanumeric or '_' | string | null | |
| description | [Optional] Provide an organization description.  Must be six or more characters | string | "Harness Organization created via Terraform" | |
| yaml_file | [Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with `var.yaml_data` | string | null | |
| yaml_data | [Optional] (String) Description of the resource. Must not be provided in conjuction with `var.yaml_file` | string | null | |
| yaml_render | [Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file | bool | true | |
| tags | [Optional] Provide a Map of Tags to associate with the organization | map(any) | {} | |
| global_tags | [Optional] Provide a Map of Tags to associate with all organizations and resources created | map(any) | {} | |

## Examples
### Build a Single Pipeline with minimal inputs
```
module "pipelines" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/pipelines"

  name            = "test-pipeline-relative"
  organization_id = "myorg"
  project_id      = "myproject"
  yaml_file       = "pipelines/ci-pipeline-demo.yaml"
  tags            = {
    role = "sample-pipeline"
  }

}
```

### Build a Single Pipeline with stage definition yaml
```
module "pipelines" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/pipelines"

  name            = "test-pipeline-raw-yaml-template"
  organization_id = "myorg"
  project_id      = "myproject"
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
  tags            = {
    role = "sample-pipeline"
  }

}
```

### Build a Single Pipeline with full yaml
```
module "pipelines" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/pipelines"

  name            = "test-pipeline-yaml-data-full"
  organization_id = "myorg"
  project_id      = "myproject"
  yaml_render     = false
  yaml_data       = <<EOT
  pipeline:
    name: test-pipeline-yaml-data-full
    identifier: test_pipeline_yaml_data_full
    projectIdentifier: myproject
    orgIdentifier: myorg
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
  tags            = {
    role = "sample-pipeline"
  }

}
```

### Build multiple Pipelines
```
variable "pipeline_list" {
    type = list(map())
    default = [
        {
            name = "alpha"
            description = "Pipeline for alpha"
            yaml_file = "files/pipeline_alpha.yml"
            tags = {
                role = "alpha"
            }
        },
        {
            name = "bravo"
            description = "Pipeline for bravo"
            yaml_file = "files/pipeline_bravo.yml"
            tags = {
                role = "bravo"
            }
        },
        {
            name = "charlie"
            description = "Pipeline for charlie"
            yaml_file = "files/pipeline_charlie.yml"
            tags = {
                role = "charlie"
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

module "pipelines" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/pipelines"
  for_each = { for pipeline in var.pipeline_list : pipeline.name => pipeline }

  name        = each.value.name
  description = each.value.description
  yaml_file   = each.value.yaml_file
  tags        = each.value.tags
  global_tags = var.global_tags
}
```

## Contributing
A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors
Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.
