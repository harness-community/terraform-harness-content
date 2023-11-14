####################
#
# Harness Pipeline Outputs
#
####################

# 2023-11-15
# This output has being deprecated and replaced by the output
# labeled `details`
# output "template_details" {
#   depends_on = [
#     time_sleep.template_setup
#   ]
#   value       = harness_platform_template.templates
#   description = "Details for the created Harness Template"
# }

output "details" {
  depends_on = [
    time_sleep.template_setup
  ]
  value       = harness_platform_template.templates
  description = "Details for the created Harness Template"
}
