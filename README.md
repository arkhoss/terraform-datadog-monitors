## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | 3.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | 3.20.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_datadog_aws_eks_monitors"></a> [datadog\_aws\_eks\_monitors](#module\_datadog\_aws\_eks\_monitors) | ./modules/aws/eks | n/a |
| <a name="module_datadog_aws_opensearch_monitors"></a> [datadog\_aws\_opensearch\_monitors](#module\_datadog\_aws\_opensearch\_monitors) | ./modules/aws/opensearch | n/a |
| <a name="module_datadog_aws_rds_monitors"></a> [datadog\_aws\_rds\_monitors](#module\_datadog\_aws\_rds\_monitors) | ./modules/aws/rds | n/a |

## Resources

| Name | Type |
|------|------|
| [datadog_monitor.this](https://registry.terraform.io/providers/DataDog/datadog/3.20.0/docs/resources/monitor) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | AWS Account Name | `string` | n/a | yes |
| <a name="input_aws_eks_cluster_name"></a> [aws\_eks\_cluster\_name](#input\_aws\_eks\_cluster\_name) | AWS EKS Cluster Name | `string` | `""` | no |
| <a name="input_aws_eks_monitor"></a> [aws\_eks\_monitor](#input\_aws\_eks\_monitor) | Enable EKS monitoring | `bool` | `false` | no |
| <a name="input_aws_opensearch_cluster_name"></a> [aws\_opensearch\_cluster\_name](#input\_aws\_opensearch\_cluster\_name) | AWS OpenSearch Cluster Name | `string` | `""` | no |
| <a name="input_aws_opensearch_monitor"></a> [aws\_opensearch\_monitor](#input\_aws\_opensearch\_monitor) | Enable OpenSearch monitoring | `bool` | `false` | no |
| <a name="input_aws_rds_cluster_name"></a> [aws\_rds\_cluster\_name](#input\_aws\_rds\_cluster\_name) | AWS RDS Cluster Name | `string` | `""` | no |
| <a name="input_aws_rds_monitor"></a> [aws\_rds\_monitor](#input\_aws\_rds\_monitor) | Enable RDS monitoring | `bool` | `false` | no |
| <a name="input_custom_monitor"></a> [custom\_monitor](#input\_custom\_monitor) | Enable custom monitor options | `bool` | `false` | no |
| <a name="input_custom_monitors_details"></a> [custom\_monitors\_details](#input\_custom\_monitors\_details) | Custom monitors details | <pre>list(object({<br>    name                 = string<br>    type                 = string<br>    message              = string<br>    escalation_message   = string<br>    query                = string<br>    monitor_thresholds   = map(string)<br>    new_group_delay      = number<br>    evaluation_delay     = number<br>    notify_no_data       = bool<br>    renotify_interval    = number<br>    renotify_occurrences = number<br>    notify_audit         = bool<br>    timeout_h            = number<br>    include_tags         = bool<br>    tags                 = map(string)<br>  }))</pre> | <pre>[<br>  {<br>    "escalation_message": "",<br>    "evaluation_delay": 0,<br>    "include_tags": false,<br>    "message": "",<br>    "monitor_thresholds": {},<br>    "name": "",<br>    "new_group_delay": 0,<br>    "notify_audit": false,<br>    "notify_no_data": false,<br>    "query": "",<br>    "renotify_interval": 0,<br>    "renotify_occurrences": 0,<br>    "tags": {},<br>    "timeout_h": 0,<br>    "type": ""<br>  }<br>]</pre> | no |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | Datadog API key | `string` | n/a | yes |
| <a name="input_datadog_app_key"></a> [datadog\_app\_key](#input\_datadog\_app\_key) | Datadog APP key | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for monitors | `string` | `""` | no |
| <a name="input_notification_channel"></a> [notification\_channel](#input\_notification\_channel) | Notification channel in DataDog i.e slack channel or PagerDuty integration | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for monitors in DataDog | `map(string)` | `{}` | no |

## Outputs

No outputs.
