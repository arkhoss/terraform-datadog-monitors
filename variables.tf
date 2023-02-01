variable "datadog_api_key" {
  type        = string
  description = "Datadog API key"
  sensitive   = true
}

variable "datadog_app_key" {
  type        = string
  description = "Datadog APP key"
  sensitive   = true
}

variable "custom_monitor" {
  type        = bool
  default     = false
  description = "Enable custom monitor options"
}

variable "custom_monitors_details" {
  type = list(object({
    name                 = string
    type                 = string
    message              = string
    escalation_message   = string
    query                = string
    monitor_thresholds   = map(string)
    new_group_delay      = number
    evaluation_delay     = number
    notify_no_data       = bool
    renotify_interval    = number
    renotify_occurrences = number
    notify_audit         = bool
    timeout_h            = number
    include_tags         = bool
    tags                 = map(string)
  }))
  default = [{
    name                 = ""
    type                 = ""
    message              = ""
    escalation_message   = ""
    query                = ""
    monitor_thresholds   = {}
    new_group_delay      = 0
    evaluation_delay     = 0
    notify_no_data       = false
    renotify_interval    = 0
    renotify_occurrences = 0
    notify_audit         = false
    timeout_h            = 0
    include_tags         = false
    tags                 = {}
  }]
  #  default = [{
  #    name               = "${var.account_name} EKS Pods CPU usage"
  #    type               = "metric alert"
  #    message            = "CPU usage high on {{kube_namespace}} {{kube_deployment}} {{pod_name}} : {{value}}  Notify: @pagerduty-DevOps${var.account_name}-EKS"
  #    escalation_message = "Escalation message @pagerduty-DevOps${var.account_name}-EKS"
  #    query              = "avg(last_5m):kubernetes.cpu.usage.total{cluster_name:${var.cluster_name}} by {pod_name,kube_namespace,kube_deployment} > 999999999"
  #    monitor_thresholds = {
  #      warning           = 899999999
  #      warning_recovery  = 799999999
  #      critical          = 999999999
  #      critical_recovery = 899999999
  #    }
  #    new_group_delay      = 300
  #    evaluation_delay     = 130
  #    notify_no_data       = false
  #    renotify_interval    = 10
  #    renotify_occurrences = 3
  #    notify_audit         = false
  #    timeout_h            = 60
  #    include_tags         = true
  #    tags                 = ["cluster_name:${cluster_name}", "environment:${environment}"]
  #  }]
  description = "Custom monitors details"
}

variable "notification_channel" {
  default     = ""
  type        = string
  description = "Notification channel in DataDog i.e slack channel or PagerDuty integration"
}

variable "environment" {
  default     = ""
  type        = string
  description = "Environment for monitors"
}

variable "aws_account_name" {
  type        = string
  description = "AWS Account Name"
}

variable "aws_eks_monitor" {
  type        = bool
  default     = false
  description = "Enable EKS monitoring"
}

variable "aws_eks_cluster_name" {
  type        = string
  default     = ""
  description = "AWS EKS Cluster Name"
}

variable "aws_rds_monitor" {
  type        = bool
  default     = false
  description = "Enable RDS monitoring"
}

variable "aws_rds_cluster_name" {
  type        = string
  default     = ""
  description = "AWS RDS Cluster Name"
}

variable "aws_opensearch_monitor" {
  type        = bool
  default     = false
  description = "Enable OpenSearch monitoring"
}

variable "aws_opensearch_cluster_name" {
  type        = string
  default     = ""
  description = "AWS OpenSearch Cluster Name"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for monitors in DataDog"
}
