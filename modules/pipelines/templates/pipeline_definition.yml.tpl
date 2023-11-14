---
pipeline:
  name: ${pipeline_name}
  identifier: ${pipeline_identifier}
  projectIdentifier: ${project_identifier}
  orgIdentifier: ${organization_identifier}
  description: ${description}
  tags:
    ${indent(4, tags)}
  ${indent(2, yaml_data)}
