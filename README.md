# terraform-aws-vpc

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_vpc | Controls if VPC should be created (it affects almost all resources) | `bool` | `true` | no |
| enable\_dns\_hostnames | Should be true to enable DNS hostnames in the VPC | `bool` | `true` | no |
| enable\_dns\_support | Should be true to enable DNS support in the VPC | `bool` | `true` | no |
| enable\_nat\_gateway | Should be true if you want to provision NAT Gateways for each of your private networks | `bool` | `false` | no |
| instance\_tenancy | A tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| name | Name to be used on all the resources as identifier | `string` | n/a | yes |
| private\_subnets | n/a | `list` | `[]` | no |
| public\_subnets | n/a | `list` | `[]` | no |
| region | The region to deploy the cluster in, e.g: us-east-1 | `string` | n/a | yes |
| single\_nat\_gateway | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | `bool` | `false` | no |
| single\_route\_table | Should be true if you want to provision a single shared Route Table across all of your public networks | `bool` | `false` | no |
| tags | A map of tags to add to all resources | `map` | `{}` | no |
| vpc\_cidr | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden | `string` | `"0.0.0.0/0"` | no |
| vpc\_id | The VPC ID. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| nat\_gateway\_ids | n/a |
| nat\_gateway\_ips | n/a |
| private\_route\_table\_ids | n/a |
| private\_subnet\_azs | n/a |
| private\_subnet\_cidr | n/a |
| private\_subnet\_ids | n/a |
| public\_route\_table\_ids | n/a |
| public\_subnet\_azs | n/a |
| public\_subnet\_cidr | n/a |
| public\_subnet\_ids | n/a |
| vpc\_id | n/a |
