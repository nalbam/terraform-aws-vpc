# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
  type        = string
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "The VPC ID."
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

# variable "enable_classiclink" {
#   description = "Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
#   type        = bool
#   default     = null
# }

# variable "enable_classiclink_dns_support" {
#   description = "Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
#   type        = bool
#   default     = null
# }

# variable "enable_ipv6" {
#   description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
#   type        = bool
#   default     = false
# }

variable "single_route_table" {
  description = "Should be true if you want to provision a single shared Route Table across all of your public networks"
  type        = bool
  default     = false
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "public_subnets" {
  # type = list(object({
  #   zone = string
  #   cidr = string
  #   tags = map
  # }))
  default = []
}

variable "private_subnets" {
  # type = list(object({
  #   zone = string
  #   cidr = string
  #   tags = map
  # }))
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
