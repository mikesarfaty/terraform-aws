variable "environment" {
  default     = "production"
  description = "The current environment"
  nullable    = false
  type        = string
}

variable "public_key_path" {
  default     = "/Users/mikesarfaty/.ssh/id_rsa.pub"
  description = "The SSH key to use. Useful for debugging nodegroup/kubelet issues."
  nullable    = true
  type        = string
}

variable "eks_create" {
  default     = false
  description = "Whether or not to create the EKS cluster"
  nullable    = false
  type        = bool
}
