########################### Elastic Search ################################
### Index Health ###
resource "datadog_monitor" "opensearch_index_health" {
  name               = "${var.aws_account_name} ElasticSearch Index health "
  type               = "metric alert"
  message            = "ElasticSearch Index health (0=red,1=yellow,2=green) : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):aws.es.alerting_index_statusgreen{aws_account:${var.aws_account_id}} by {domainname}  <= 0 "

  monitor_thresholds {
    warning           = 1
    warning_recovery  = 2
    critical          = 0
    critical_recovery = 2
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 60
  include_tags = true

  tags = ["cluster:${var.aws_opensearch_cluster_name}", "environment:${var.environment}"]
}

### Cluster overall Health ###
resource "datadog_monitor" "opensearch-cluster-health" {
  name               = "${var.aws_account_name} ElasticSearch cluster health "
  type               = "metric alert"
  message            = "ElasticSearch cluster health (0=red,1=yellow,2=green) : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):aws.es.cluster_statusgreen{aws_account:${var.aws_account_id}} by {domainname}  <= 0 "

  monitor_thresholds {
    warning           = 1
    warning_recovery  = 2
    critical          = 0
    critical_recovery = 2
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_opensearch_cluster_name}", "environment:${var.environment}"]
}
