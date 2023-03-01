####################
#
# Harness Pipeline Outputs
#
####################
output "pipeline_details" {
  depends_on = [
    time_sleep.pipeline_setup
  ]
  value = harness_platform_pipeline.pipelines
  description = "Details for the created Harness Pipeline"
}
