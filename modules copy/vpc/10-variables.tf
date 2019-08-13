# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "city" {
  description = "City Name of the cluster, e.g: virginia"
}

variable "stage" {
  description = "Stage Name of the cluster, e.g: dev"
}

variable "name" {
  description = "Name of the cluster, e.g: demo"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
