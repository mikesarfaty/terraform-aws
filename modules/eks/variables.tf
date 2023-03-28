variable "kubernetes_version" {
  default     = "1.25"
  description = "The version of kubernetes to run"
  type        = string
  nullable    = false
}

variable "cluster_name" {
  default     = "main"
  description = "The name of the EKS cluster"
  type        = string
  nullable    = false
}

variable "tags" {
  description = "Extra tags to append to all resources"
  type        = map(string)
}

variable "key_pair_name" {
  description = "The key pair ARN to use for nodegroup nodes."
  type        = string
}

variable "in_public_subnets" {
  description = "Whether or not this EKS cluster will be launched in a public subnet"
  default     = false
  type        = bool
  nullable    = false
}
