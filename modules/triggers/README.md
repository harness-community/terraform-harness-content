# Terraform Modules for Harness Pipelines
Terraform Module for creating and managing Harness Pipelines

## Summary
This module handle the creation and managment of pipelines by leveraging the Harness Terraform provider

## Supported Terraform Versions
    - v1.3.7
    - v1.3.8
    - v1.3.9
    - v1.4.0

## Providers

```
terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "~> 0.14"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
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
| project_id | [Required] Provide an project reference ID.  Must exist before execution | string | | X |
| pipeline_id | [Required] Provide an pipeline reference ID.  Must exist before execution | string | | X |
| identifier | [Optional] Provide a custom identifier.  More than 2 but less than 128 characters and can only include alphanumeric or '_' | string | null | |
| description | [Optional] Provide an organization description.  Must be six or more characters | string | "Harness Organization created via Terraform" | |
| yaml_file | [Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with `var.yaml_data` | string | null | |
| yaml_data | [Optional] (String) Description of the resource. Must not be provided in conjuction with `var.yaml_file` | string | null | |
| yaml_render | [Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file | bool | true | |
| trigger_enabled | [Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file | bool | true | |
| tags | [Optional] Provide a Map of Tags to associate with the organization | map(any) | {} | |
| global_tags | [Optional] Provide a Map of Tags to associate with all organizations and resources created | map(any) | {} | |

## Outputs
| Name | Description | Value |
| --- | --- | --- |
| details | Details for the created Harness Trigger | Map containing details of created trigger

## Examples
### Build a Single Trigger with minimal inputs
```
module "triggers" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/triggers"

  name            = "test-trigger"
  organization_id = "myorg"
  project_id      = "myproject"
  pipeline_id     = "mypipeline"
  yaml_file       = "triggers/basic-trigger-example.yaml"
  tags            = {
    role = "sample-trigger"
  }

}
```

### Build a Single Trigger with yaml
```
module "pipelines" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/pipelines"

  name            = "test-trigger"
  organization_id = "myorg"
  project_id      = "myproject"
  pipeline_id     = "mypipeline"
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
  tags            = {
    role = "sample-pipeline"
  }

}
```

### Build a Single Pipeline with full yaml
```
module "pipelines" {
  source = "git@github.com:harness-community/terraform-harness-content.git//modules/pipelines"

  name            = "test-trigger"
  organization_id = "myorg"
  project_id      = "myproject"
  pipeline_id     = "mypipeline"
  yaml_render     = false
  yaml_data       = <<EOT
  trigger:
    name: test-trigger
    identifier: test_trigger
    orgIdentifier: myorg
    projectIdentifier: myproject
    pipelineIdentifier: mypipeline
    description: Harness Pipeline Trigger created via Terraform
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
  tags            = {
    role = "sample-trigger"
  }

}
```

## Contributing
A complete [Contributors Guide](../CONTRIBUTING.md) can be found in this repository

## Authors
Module is maintained by Harness, Inc

## License

MIT License. See [LICENSE](../LICENSE) for full details.