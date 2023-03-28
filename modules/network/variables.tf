variable "network_prefix" {
  description = "The name of the VPC"
  type        = string
  nullable    = false
}

variable "vpc_cidr_range" {
  description = "The range for all subnets in this VPC"
  type        = string
  nullable    = false
}

variable "tags" {
  description = "Extra tags to append to all network resources"
  type        = map(string)
}

variable "environment" {
  description = "The environment we're deploying to"
  type        = string
  nullable    = false
}

variable "private_subnet_ct" {
  description = "The number of private subnets to create"
  type        = number
  nullable    = false
  default     = 0
}

variable "public_subnet_ct" {
  description = "The number of public subnets to create"
  type        = number
  nullable    = false
}
