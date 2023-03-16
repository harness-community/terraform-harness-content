####################
#
# Harness Trigger Outputs
#
####################
output "details" {
  depends_on = [
    time_sleep.trigger_setup
  ]
  value       = harness_platform_triggers.trigger
  description = "Details for the created Harness Pipeline Trigger"
}
