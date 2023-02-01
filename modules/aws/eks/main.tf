################ Datadog Alarms for EKS Pods ###############
##### Pods CPU Utilization #####
resource "datadog_monitor" "eks_pods_cpu" {
  name               = "${var.aws_account_name} - EKS Pods CPU usage"
  type               = "metric alert"
  message            = "CPU usage high on {{kube_namespace}} {{kube_deployment}} {{pod_name}} : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):kubernetes.cpu.usage.total{cluster_name:${var.aws_eks_cluster_name}} by {pod_name,kube_namespace,kube_deployment} > 999999999"

  monitor_thresholds {
    warning           = 899999999
    warning_recovery  = 799999999
    critical          = 999999999
    critical_recovery = 899999999
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3


  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_eks_cluster_name}", "environment:${var.environment}"]
}

##### Pods Memory Utilization #####
resource "datadog_monitor" "eks_pods_memory" {
  name               = "${var.aws_account_name} EKS Pods Memory usage"
  type               = "metric alert"
  message            = "Memory usage high on {{kube_namespace}} {{kube_deployment}}: {{pod_name}} : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_10m):kubernetes.memory.usage_pct{cluster_name:${var.aws_eks_cluster_name}} by {pod_name,kube_namespace,kube_deployment} >= 0.95"

  monitor_thresholds {
    warning           = 0.9
    warning_recovery  = 0.8
    critical          = 0.95
    critical_recovery = 0.9
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_eks_cluster_name}", "environment:${var.environment}"]
}

####### Pods Disk Usage #########
resource "datadog_monitor" "eks_pods_disk" {
  name               = "${var.aws_account_name} EKS Pods Disk usage"
  type               = "metric alert"
  message            = "Disk usage high on {{kube_namespace}} {{kube_deployment}}: {{pod_name}} : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message @pagerduty-DevOps${var.aws_account_name}-EKS"

  query = "avg(last_5m):kubernetes.ephemeral_storage.usage{cluster_name:${var.aws_eks_cluster_name}} by {pod_name,host,kube_namespace} >= 171798691840"

  monitor_thresholds {
    warning           = 150323855360
    warning_recovery  = 128849018880
    critical          = 171798691840
    critical_recovery = 150323855360
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_eks_cluster_name}", "environment:${var.environment}"]
}

######## Pods Status Phase ########
resource "datadog_monitor" "eks_pods_status_failed" {
  name               = "${var.aws_account_name} EKS Pods status phase failed "
  type               = "metric alert"
  message            = "Pod from {{kube_namespace}} {{kube_deployment}}: {{pod_name}} : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):kubernetes_state.pod.status_phase{cluster_name:${var.aws_eks_cluster_name},pod_phase:failed} by {pod_phase} >= 3"

  monitor_thresholds {
    critical          = 3
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


  tags = ["cluster:${var.aws_eks_cluster_name}", "environment:${var.environment}"]
}

resource "datadog_monitor" "eks_pods_status_pending" {
  name               = "${var.aws_account_name} EKS Pods status phase pending "
  type               = "metric alert"
  message            = "Pod from {{kube_namespace}} {{kube_deployment}}: {{pod_name}} : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):kubernetes_state.pod.status_phase{cluster_name:${var.aws_eks_cluster_name},pod_phase:pending} by {pod_phase} >= 2"

  monitor_thresholds {
    critical          = 2
    critical_recovery = 1
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_eks_cluster_name}", "environment:${var.environment}"]
}
################ Datadog Alarms for EKS Nodes ###############
#####  Nodes CPU Utilization ######

resource "datadog_monitor" "eks_nodes_cpu" {
  name               = "${var.aws_account_name} EKS Node CPU usage"
  type               = "metric alert"
  message            = "CPU usage high on {{host}} : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):system.cpu.user{cluster_name:${var.aws_eks_cluster_name}} by {host} > 80"

  monitor_thresholds {
    warning           = 70
    warning_recovery  = 60
    critical          = 80
    critical_recovery = 75
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true


  tags = ["cluster:${var.aws_eks_cluster_name}", "environment:${var.environment}"]
}

#####  Nodes Memory Utilization ######

resource "datadog_monitor" "eks_nodes_memory" {
  name               = "${var.aws_account_name} EKS Node Memory usage "
  type               = "metric alert"
  message            = "Memory usage high on {{host}} : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):kubernetes.memory.usage_pct{cluster_name:${var.aws_eks_cluster_name}} by {host} > 80"

  monitor_thresholds {
    warning           = 70
    warning_recovery  = 60
    critical          = 80
    critical_recovery = 75
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_eks_cluster_name}", "environment:${var.environment}"]
}


#####  Nodes Disk Utilization ######
resource "datadog_monitor" "eks_nodes_disk" {
  name               = "${var.aws_account_name} EKS Node Disk usage "
  type               = "metric alert"
  message            = "Disk usage high on {{host}} : {{value}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):kubernetes.filesystem.usage_pct{cluster_name:${var.aws_eks_cluster_name}} by {host} >= 0.5"

  monitor_thresholds {
    warning           = 0.3
    warning_recovery  = 0.2
    critical          = 0.5
    critical_recovery = 0.3
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_eks_cluster_name}", "environment:${var.environment}"]
}


#####  Nodes Not in ready state ######
resource "datadog_monitor" "eks_nodes_notready" {
  name               = "${var.aws_account_name} EKS Node not ready state "
  type               = "metric alert"
  message            = "Number of nodes not ready : {{value}} :- {{host}} Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):sum:kubernetes_state.nodes.by_condition{condition NOT IN (ready) AND status NOT IN (true) AND cluster_name:${var.aws_eks_cluster_name} } by {condition,aws_autoscaling_groupname} > 1"

  monitor_thresholds {
    warning           = 7
    warning_recovery  = 6
    critical          = 8
    critical_recovery = 7
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_eks_cluster_name}", "environment:${var.environment}"]
}


####################### HPA Status ################################
### HPA Condition ###
resource "datadog_monitor" "eks_hpa_condition" {
  name               = "${var.aws_account_name} HPA condition"
  type               = "metric alert"
  message            = "HPA condition of {{hpa}} : {{value}} , {{condition}} and {{status}}  Notify: ${var.notification_channel}"
  escalation_message = "Escalation message ${var.notification_channel}"

  query = "avg(last_5m):kubernetes_state.hpa.condition{cluster_name:${var.aws_eks_cluster_name} AND condition NOT IN (abletoscale,scalingactive,scalinglimited) AND status NOT IN (true)} by {hpa,condition,status} >= 1 "

  monitor_thresholds {
    critical          = 1
    critical_recovery = 0
  }

  new_group_delay      = 300
  evaluation_delay     = 130
  notify_no_data       = false
  renotify_interval    = 10
  renotify_occurrences = 3

  notify_audit = false
  timeout_h    = 24
  include_tags = true

  tags = ["cluster:${var.aws_eks_cluster_name}", "environment:${var.environment}"]
}
