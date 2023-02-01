variable "notification_channel" {
  default     = ""
  type        = string
  description = "Notification channel in DataDog i.e slack channel or PagerDuty integration"
}

variable "aws_account_name" {
  type        = string
  description = "AWS Account Name"
}

variable "aws_eks_cluster_name" {
  type        = string
  description = "AWS EKS Cluster Name"
}


variable "environment" {
  default     = ""
  type        = string
  description = "Environment for monitors"
}
