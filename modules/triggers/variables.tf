####################
#
# Harness Pipeline Variables
#
####################
variable "identifier" {
  type        = string
  description = "[Optional] Provide a custom identifier.  Must be at least 1 character but less than 128 characters and can only include alphanumeric or '_'"
  default     = null

  validation {
    condition = (
      var.identifier != null
      ?
      can(regex("^[0-9A-Za-z][0-9A-Za-z_]{0,127}$", var.identifier))
      :
      true
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide a custom identifier.  Must be at least 1 character but less than 128 characters and can only include alphanumeric or '_'.
            Note: If not set, Terraform will auto-assign an identifier based on the name of the resource
        EOF
  }
}
variable "name" {
  type        = string
  description = "[Required] Provide a Trigger name. Must be at least 1 character but but less than 128 characters"

  validation {
    condition = (
      length(var.name) > 1
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide a Trigger name. Must be at least 1 character but but less than 128 characters.
        EOF
  }
}
variable "organization_id" {
  type        = string
  description = "[Required] Provide an organization reference ID.  Must exist before execution"

  validation {
    condition = (
      length(var.organization_id) > 2
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide an organization name.  Must exist before execution.
        EOF
  }
}

variable "project_id" {
  type        = string
  description = "[Required] Provide an existing project reference ID.  Must exist before execution"

  validation {
    condition = (
      anytrue([
        can(regex("^([a-zA-Z0-9_]*)", var.project_id))
      ])
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide an existing project id.  Must exist before execution.
        EOF
  }
}

variable "pipeline_id" {
  type        = string
  description = "[Required] Provide an existing pipeline reference ID.  Must exist before execution"

  validation {
    condition = (
      anytrue([
        can(regex("^([a-zA-Z0-9_]*)", var.pipeline_id))
      ])
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Required] Provide an existing pipeline reference ID.  Must exist before execution.
        EOF
  }
}

variable "description" {
  type        = string
  description = "[Optional] (String) Description of the resource."
  default     = "Harness Pipeline created via Terraform"

  validation {
    condition = (
      length(var.description) > 6
    )
    error_message = <<EOF
        Validation of an object failed.
            * [Optional] Provide an Pipeline description.  Must be six or more characters.
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

variable "trigger_enabled" {
  type        = bool
  description = "[Optional] (Boolean) Determines if the trigger should be enabled or disabled"
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
