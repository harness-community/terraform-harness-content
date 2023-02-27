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
### Build a Single Project with minimal inputs
```
module "project" {
  source = "git@github.com:harness-community/terraform-harness-structure.git//projects"

  name            = "project1"
  organization_id = "myorg"
}
```

### Build multiple projects
```
variable "project_list" {
    type = list(map())
    default = [
        {
            name = "alpha"
            description = "Project for alpha"
            tags = {
                purpose = "alpha"
            }
        },
        {
            name = "bravo"
            description = "Project for bravo"
            tags = {
                purpose = "bravo"
            }
        },
        {
            name = "charlie"
            description = "Project for charlie"
            tags = {
                purpose = "charlie"
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

module "projects" {
  source = "git@github.com:harness-community/terraform-harness-structure.git//projects"
  for_each = { for project in var.project_list : project.name => project }

  name        = each.value.name
  description = each.value.description
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