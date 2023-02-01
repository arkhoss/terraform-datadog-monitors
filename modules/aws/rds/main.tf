####################### RDS database ################################
### Maximum Connection ###
resource "datadog_monitor" "rds_max_connections" {
  name               = "${var.aws_account_name} Maximum RDS connections "
  type               = "metric alert"
  message            = "Max Connections on {{application}} : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):postgresql.max_connections{cluster-name:${var.aws_rds_cluster_name}}  >= 600 "

  monitor_thresholds {
    warning           = 500
    warning_recovery  = 400
    critical          = 600
    critical_recovery = 500
  }


  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_rds_cluster_name}", "environment:${var.environment}"]
}

### Deadlock Detected ###
resource "datadog_monitor" "rds_deadlocks" {
  name               = "${var.aws_account_name} Deadlocks detected "
  type               = "metric alert"
  message            = "Deadlocks detected in {{application}} : {{value}}  Notify: ${var.aws_rds_cluster_name}"
  escalation_message = "Escalation message ${var.aws_rds_cluster_name}"

  query = "avg(last_5m):postgresql.deadlocks{cluster-name:${var.aws_rds_cluster_name}} by {application}  >= 0.5 "

  monitor_thresholds {
    warning           = 0.3
    warning_recovery  = 0.2
    critical          = 0.5
    critical_recovery = 0.4
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_rds_cluster_name}", "environment:${var.environment}"]
}
