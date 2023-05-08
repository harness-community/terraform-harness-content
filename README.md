# Terraform Modules for Harness Platform Content
A collection of Terraform resources used to support the pipelines and templates of the Harness Platform

## Goal
The goal of this repository is to provide simple to consume versions of the Harness Terraform resources in such a way to make the management of Harness via Terraform easy to adopt.

## Summary
This collection of Terraform modules focuses on the initial setup of Harness Platform pipeline and template functionality.

## Providers

```
terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
  }
}
```

## Variables
| Name | Description | Type | Default Value | Mandatory |
| --- | --- | --- | --- | --- |
| harness_platform_url | [Optional] Enter the Harness Platform URL.  Defaults to Harness SaaS URL | string | https://app.harness.io/gateway | |
| harness_platform_account | [Required] Enter the Harness Platform Account Number | string | | X |
| harness_platform_key | [Required] Enter the Harness Platform API Key for your account | string | | X |
| organization_name | Provide an organization name.  Must exist before execution | string | default | |
| project_name | Provide an project name in the chosen organization.  Must exist before execution | string | Default Project | |

## Examples
### Retrieve default module outputs
```
module "harness_content" {
  source = "git@github.com:harness-community/terraform-harness-content.git"

  harness_platform_account = "myaccount_id"
  harness_platform_key = "myplatform_key"
  organization_name = "default"
  project_name = "Default Project"
}
```

## Additional Module Details

### Pipelines
Create and manage new Harness Platform Pipelines.  Read more about this module in the [README](modules/pipelines/README.md)

### Templates
Create and manage new Harness Platform Templates.  Read more about this module in the [README](modules/templates/README.md)

### Triggers
Create and manage new Harness Platform Triggers.  Read more about this module in the [README](modules/triggers/README.md)

### Input Sets
Create and manage new Harness Platform Input Sets.  Read more about this module in the [README](modules/input_sets/README.md)

## Contributing
A complete [Contributors Guide](CONTRIBUTING.md) can be found in this repository

## Authors
Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](LICENSE) for full details.
