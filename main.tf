# Configure the Datadog provider    
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# Main
data "aws_caller_identity" "current" {}

# Custom Monitors
resource "datadog_monitor" "this" {
  for_each           = var.custom_monitor && length(var.custom_monitors_details) > 0 ? toset(var.custom_monitors_details) : []
  name               = element(var.custom_monitors_details, each.key).name
  type               = element(var.custom_monitors_details, each.key).type
  message            = element(var.custom_monitors_details, each.key).message
  escalation_message = element(var.custom_monitors_details, each.key).escalation_message

  query = element(var.custom_monitors_details, each.key).query

  monitor_thresholds {
    warning           = element(var.custom_monitors_details, each.key).monitor_thresholds.warning
    warning_recovery  = element(var.custom_monitors_details, each.key).monitor_thresholds.warning_recovery
    critical          = element(var.custom_monitors_details, each.key).monitor_thresholds.critical
    critical_recovery = element(var.custom_monitors_details, each.key).monitor_thresholds.critical_recovery
  }

  new_group_delay      = element(var.custom_monitors_details, each.key).new_group_delay
  evaluation_delay     = element(var.custom_monitors_details, each.key).evaluation_delay
  notify_no_data       = element(var.custom_monitors_details, each.key).notify_no_data
  renotify_interval    = element(var.custom_monitors_details, each.key).renotify_interval
  renotify_occurrences = element(var.custom_monitors_details, each.key).renotify_occurrences


  notify_audit = element(var.custom_monitors_details, each.key).notify_audit
  timeout_h    = element(var.custom_monitors_details, each.key).timeout_h
  include_tags = element(var.custom_monitors_details, each.key).include_tags

  tags = []
}

module "datadog_aws_eks_monitors" {
  count  = var.aws_eks_monitor ? 1 : 0
  source = "./modules/aws/eks"

  notification_channel = var.notification_channel
  aws_account_name     = var.aws_account_name
  aws_eks_cluster_name = var.aws_eks_cluster_name
}

module "datadog_aws_rds_monitors" {
  count  = var.aws_rds_monitor ? 1 : 0
  source = "./modules/aws/rds"

  notification_channel = var.notification_channel
  aws_account_name     = var.aws_account_name
  aws_rds_cluster_name = var.aws_rds_cluster_name
}

module "datadog_aws_opensearch_monitors" {
  count  = var.aws_opensearch_monitor ? 1 : 0
  source = "./modules/aws/opensearch"

  notification_channel        = var.notification_channel
  aws_account_name            = var.aws_account_name
  aws_opensearch_cluster_name = var.aws_opensearch_cluster_name
}
