####################
#
# Harness Input Sets Outputs
#
####################
output "details" {
  depends_on = [
    time_sleep.input_set_setup
  ]
  value       = harness_platform_input_set.set
  description = "Details for the created Harness Pipeline Input Set"
}
