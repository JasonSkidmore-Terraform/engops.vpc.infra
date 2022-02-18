variable "tenant" {
  type = string
  description = "AWS account name or unique id for tenant"
}

variable "environment" {
  type = string
  description = "Environment area eg., dev,stage,prod"
}

variable "project" {
  type = string
  description = "project or application name. AKA estate"
}

variable "vpc_cidr" {
  type = string
  description = "vpc cidr block"
}

variable "enable_ipv6" {
  type = bool
  description = "true|false enable ipv6"
}

variable "enable_nat_gateway" {
  type = bool
  description = "true|false enable nat gateway"
}

variable "single_nat_gateway" {
  type = bool
  description = "true|false enable single nat gateway"
}
