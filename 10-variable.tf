# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "name" {
  description = "Name of the cluster, e.g: seoul-dev-demo"
}

variable "vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  default = []
}

variable "private_subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "public_tags" {
  description = "A map of tags to add to public resources"
  default     = {}
}

variable "private_tags" {
  description = "A map of tags to add to private resources"
  default     = {}
}
