---
template:
    name: ${pipeline_name}
    identifier: ${pipeline_identifier}
    %{ if project_identifier != null }projectIdentifier: ${project_identifier}%{~ endif }
    %{ if organization_identifier != null }orgIdentifier: ${organization_identifier}%{~ endif }
    description: ${description}
    versionLabel: ${version_label}
    type: ${type}
    ${indent(4, yaml_data)}
