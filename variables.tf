variable region {
  default = "ap-northeast-2"
}

variable "name" {
  description = "Name to be used on all resources as prefix"
  default = ""
}

variable "key_name" {
  description = "The key name to use for the instance"
  default = ""
}
