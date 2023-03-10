####################
#
# Harness Template Variables
#
####################
variable "identifier" {
  type        = string
  description = "[Optional] Provide a custom identifier.  More than 2 but less than 128 characters and can only include alphanumeric or '_'"
  default     = null

  validation {
    condition = (
      var.identifier != null
      ?
      can(regex("^[0-9A-Za-z][0-9A-Za-z_]{2,127}$", var.identifier))
      :
      true
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide a custom identifier.  More than 2 but less than 128 characters and can only include alphanumeric or '_'.
            Note: If not set, Terraform will auto-assign an identifier based on the name of the resource
        EOF
  }
}

variable "name" {
  type        = string
  description = "[Required] (String) Name of the resource."

  validation {
    condition = (
      length(var.name) > 2
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide a project name. Must be two or more characters.
        EOF
  }
}

variable "organization_id" {
  type        = string
  description = "[Optional] Provide an organization reference ID. Must exist before execution"
  default     = null

  validation {
    condition = (
      anytrue([
        var.organization_id == null,
        (
          var.organization_id != null ? length(var.organization_id) > 2 : true
        )
      ])
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide an organization name. Must exist before execution.
        EOF
  }
}

variable "project_id" {
  type        = string
  description = "[Optional] Provide an project reference ID. Must exist before execution"
  default     = null

  validation {
    condition = (
      anytrue([
        can(regex("^([a-zA-Z0-9_]*)", var.project_id)),
        var.project_id == null
      ])
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide an project name. Must exist before execution.
        EOF
  }
}

variable "template_version" {
  type        = string
  description = "[Required] Version Label for Template."

  validation {
    condition = (
      length(var.template_version) > 0
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide a valid version string.
        EOF
  }
}

variable "type" {
  type        = string
  description = "[Required] (String) Type of Template"

  validation {
    condition = (
      contains(["CustomDeployment", "Deployment", "MonitoredService", "Stage", "Step", "Pipeline", "SecretManager"], var.type)
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide the Template type. Valid types are: Deployment, MonitoredService, Stage, Step, Pipeline or SecretManager.
        EOF
  }
}

variable "comments" {
  type        = string
  description = "[Optional] (String) Specify comment with respect to changes."
  default     = "Changes to Template managed by Terraform"

  validation {
    condition = (
      length(var.comments) > 6
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide Template change comments. Must be six or more characters.
        EOF
  }
}

variable "description" {
  type        = string
  description = "[Optional] (String) Description of the resource."
  default     = "Harness Template created via Terraform"

  validation {
    condition = (
      length(var.description) > 6
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide a Template description. Must be six or more characters.
        EOF
  }
}

variable "yaml_file" {
  type        = string
  description = "[Optional] (String) File Path to yaml snippet to include. Must not be provided in conjuction with var.yaml_data"
  default     = null
}

variable "yaml_data" {
  type        = string
  description = "[Optional] (String) Description of the resource."
  default     = null
}

variable "yaml_render" {
  type        = bool
  description = "[Optional] (Boolean) Determines if the pipeline data should be templatized or is a full pipeline reference file"
  default     = true
}

variable "is_stable" {
  type        = bool
  description = "[Optional] (Boolean) If true, given version for Template to be set as stable."
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the project"
  default     = {}

  validation {
    condition = (
      length(keys(var.tags)) == length(values(var.tags))
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide a Map of Tags to associate with the project
        EOF
  }
}

variable "global_tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the project and resources created"
  default     = {}

  validation {
    condition = (
      length(keys(var.global_tags)) == length(values(var.global_tags))
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide a Map of Tags to associate with the project and resources created
        EOF
  }
}
