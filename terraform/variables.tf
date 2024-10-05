variable "project" {
  type    = string
  default = "gitlab-ce"
}

variable "resource_group_name" {
  type    = string
  default = "gitlab-ce"
}

variable "vnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}
