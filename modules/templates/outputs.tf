####################
#
# Harness Pipeline Outputs
#
####################
output "template_details" {
  depends_on = [
    time_sleep.template_setup
  ]
  value = harness_platform_template.templates
  description = "Details for the created Harness Template"
}
