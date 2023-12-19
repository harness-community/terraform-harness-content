# Terraform Modules for Harness Input Sets
Terraform Module for creating and managing Harness Input Sets

## Summary
This module handle the creation and managment of Input Sets by leveraging the Harness Terraform provider

## Supported Terraform Versions
_Note: These modules require a minimum of Terraform Version 1.2.0 to support the Input Validations and Precondition Lifecycle hooks leveraged in the code._

_Note: The list of supported Terraform Versions is based on the most recent of each release which has been tested against this module._

    - v1.2.9
    - v1.3.9
    - v1.4.7
    - v1.5.7
    - v1.6.0
    - v1.6.1
    - v1.6.2
    - v1.6.3
    - v1.6.4
    - v1.6.5
    - v1.6.6

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
| name | [Required] Provide an organization name.  Must be two or more characters | string | | X |
| organization_id | [Required] Provide an organization reference ID.  Must exist before execution | string | | X |
| project_id | [Required] Provide an project reference ID.  Must exist before execution | string | | X |
| pipeline_id | [Required] Provide an pipeline reference ID.  Must exist before execution | string | | X |
| description | [Optional] Provide an organization description.  Must be six or more characters | string | "Harness Organization created via Terraform" | |
| yaml_file | [Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with `var.yaml_data` | string | null | |
| yaml_data | [Optional] (String) Description of the resource. Must not be provided in conjuction with `var.yaml_file` | string | null | |
| yaml_render | [Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file | bool | true | |
| case_sensitive | [Optional] Should identifiers be case sensitive by default? (Note: Setting this value to `true` will retain the case sensitivity of the identifier) | bool | false | |
| tags | [Optional] Provide a Map of Tags to associate with the organization | map(any) | {} | |
| global_tags | [Optional] Provide a Map of Tags to associate with all organizations and resources created | map(any) | {} | |

## Outputs
| Name | Description | Value |
| --- | --- | --- |
| details | Details for the created Harness Input Sets | Map containing details of created input_sets

## Examples
### Build a Single Input Set with minimal inputs
```
module "input_sets" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/input_sets"

  name            = "test-input-set"
  organization_id = "myorg"
  project_id      = "myproject"
  pipeline_id     = "mypipeline"
  yaml_file       = "input_sets/basic-input-set-example.yaml"
  tags            = {
    role = "sample-input-set"
  }

}
```

### Build a Single Input Set with yaml
```
module "input_sets" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/input_sets"

  name            = "test-input-set"
  organization_id = "myorg"
  project_id      = "myproject"
  pipeline_id     = "mypipeline"
  yaml_data       = <<EOT
  variables:
    - name: myvar
      value: success
  EOT
  tags            = {
    role = "sample-pipeline"
  }

}
```

### Build a Single Input Set with full yaml
```
module "input_sets" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/input_sets"

  name            = "test-input-set"
  organization_id = "myorg"
  project_id      = "myproject"
  pipeline_id     = "mypipeline"
  yaml_render     = false
  yaml_data       = <<EOT
  inputSet:
    name: test-input-set
    identifier: test_input_set
    orgIdentifier: myorg
    projectIdentifier: myproject
    description: Harness Input Set created via Terraform
    pipeline:
      identifier: mypipeline
      variables:
        - name: myvar
          value: success

  EOT
  tags            = {
    role = "sample-trigger"
  }

}
```

## Contributing
A complete [Contributors Guide](../../CONTRIBUTING.md) can be found in this repository

## Authors
Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../../LICENSE) for full details.
