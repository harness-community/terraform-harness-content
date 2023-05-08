---
inputSet:
  name: ${input_set_name}
  identifier: ${input_set_identifier}
  projectIdentifier: ${project_identifier}
  orgIdentifier: ${organization_identifier}
  description: ${description}
  pipeline:
    identifier: ${pipeline_identifier}
    ${indent(4, yaml_data)}
