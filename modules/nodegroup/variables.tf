variable "kubernetes_version" {
  default     = "1.25"
  description = "The version of kubernetes to run"
  type        = string
  nullable    = false
}

variable "name" {
  default     = "workload"
  description = "The name of the node group"
  type        = string
  nullable    = false
}

variable "cluster_name" {
  description = "The name of the cluster this node group belongs to"
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

variable "subnet_ids" {
  description = "The Subnet IDs to launch instances into."
  type        = list(string)
  nullable    = false
}
