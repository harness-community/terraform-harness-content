---
pipeline:
    name: ${pipeline_name}
    identifier: ${pipeline_identifier}
    projectIdentifier: ${project_identifier}
    orgIdentifier: ${organization_identifier}
    description: ${description}
    ${indent(4, yaml_data)}
