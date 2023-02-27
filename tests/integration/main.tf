# Depends on
# - harness_pipelines.tf
# - harness_templates.tf

# Create Testing infrastructure
resource "harness_platform_organization" "test" {
  identifier  = "${local.fmt_prefix}_terraform_harness_content"
  name        = "${local.fmt_prefix}-terraform-harness-content"
  description = "Testing Organization for Terraform Harness Content"
  tags        = ["purpose:terraform-testing"]
}

resource "harness_platform_project" "test" {
  identifier = "terraform_harness_content"
  name       = "terraform-harness-content"
  org_id     = harness_platform_organization.test.id
  color      = "#0063F7"
  tags       = ["purpose:terraform-testing"]
}
