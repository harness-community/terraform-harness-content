---
template:
  name: ${pipeline_name}
  identifier: ${pipeline_identifier}
  %{ if project_identifier != null }projectIdentifier: ${project_identifier}%{~ endif }
  %{ if organization_identifier != null }orgIdentifier: ${organization_identifier}%{~ endif }
  versionLabel: ${version_label}
  type: ${type}
  tags:
    ${indent(4, tags)}
  ${indent(4, yaml_data)}
