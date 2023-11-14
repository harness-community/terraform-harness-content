---
trigger:
  name: ${trigger_name}
  identifier: ${trigger_identifier}
  projectIdentifier: ${project_identifier}
  orgIdentifier: ${organization_identifier}
  pipelineIdentifier: ${pipeline_identifier}
  description: ${description}
  tags:
    ${indent(4, tags)}
  ${indent(2, yaml_data)}
  enabled: ${trigger_enabled}
