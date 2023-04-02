variable "name" {
  description = "The name of the AutoScaling Group and associated resources"
  nullable    = false
  type        = string
}

variable "tags" {
  description = "Tags to provision to all ASG resources"
  type        = map(string)
  default     = {}
}

variable "allowed_instance_types" {
  description = "The type of instance you'd like to launch"
  default = [
    "t3*",
    "t4g*",
    "t3a*",
    "t2*",
    "m6gd*",
    "m5*"

  ]
  nullable = false
  type     = list(string)
}

variable "spot_instance_min_reserve_time" {
  description = "The min amount of time you want to keep these spot instances, in minutes"
  default     = 240
  type        = number
}

variable "is_public_asg" {
  description = "Whether or not the ASG should launch public instances"
  default     = true
  type        = bool
  nullable    = false
}

variable "spot_instance_requirements" {
  description = "The attributes for selecting spot instances"
  type        = object({ memory_mib = object({ min = number, max = number }), vcpu_count = object({ min = number, max = number }) })
  default = {
    "memory_mib" : {
      "min" : 4 * 1024,
      "max" : 8 * 1024
    },
    "vcpu_count" = {
      "min" : 2,
      "max" : 4
    }
  }
}

variable "spot_max_price_per_hour" {
  description = "The max price to pay (per hour) for a spot instance"
  default     = 0.1
  type        = number
  nullable    = false
}

variable "ssh_key_pair_name" {
  description = "The name of the SSH key to allow SSH auth from."
  type        = string
}

variable "extra_sg_ids" {
  description = "Extra security groups to add to instances in this ASG."
  default     = []
  type        = list(string)
  nullable    = false
}
