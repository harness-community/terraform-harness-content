####################
#
# Harness Pipeline Outputs
#
####################

# 2023-03-16
# This output is being deprecated and replaced by the output
# labeled `details`
output "pipeline_details" {
  depends_on = [
    time_sleep.pipeline_setup
  ]
  value       = harness_platform_pipeline.pipelines
  description = "Details for the created Harness Pipeline"
}

output "details" {
  depends_on = [
    time_sleep.pipeline_setup
  ]
  value       = harness_platform_pipeline.pipelines
  description = "Details for the created Harness Pipeline"
}
