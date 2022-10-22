resource "aws_cloudformation_stack_set" "this" {
  provider = aws.frankfurt

  name        = "TerraformStateInfrastructure"
  description = "Creates Terraform state infrastructure in the target accounts"

  operation_preferences {
    failure_tolerance_count = 3
    max_concurrent_count = 1
    region_concurrency_type = "PARALLEL"
  }

  #parameters = {
  #  AdministratorAccountId = "470214011505"
  #}

  auto_deployment {
    enabled                          = true
    retain_stacks_on_account_removal = false
  }

  permission_model    = "SERVICE_MANAGED" # SERVICE_MANAGED / SELF_MANAGED
  #execution_role_name = "AWSCloudFormationStackSetExecutionRole"

  #template_url = null
  template_body = file("terraform-state-infrastructure.yml")
}

resource "aws_cloudformation_stack_set_instance" "this" {
  provider = aws.frankfurt

  #account_id     = "385265377055" # callofthevoid-prod
  region         = "eu-central-1"
  stack_set_name = aws_cloudformation_stack_set.this.name
  retain_stack   = false

  deployment_targets {
    organizational_unit_ids = [
      "ou-mdnl-ckkv1n8o" # Workloads
    ]
  }
}