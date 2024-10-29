variable "bastion_ami" {
  description = "ID of AMI Amazon linux to use for the instance"
  type        = string

}

variable "bastion_associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = true
}

variable "bastion_instance_type" {
  description = "The type of instance to start"
  type        = string

}

variable "bastion_key_name" {
  description = "The key name to use for the instance"
  type        = string

}

variable "bastion_tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host"
  type        = string
  default     = "default"
}

variable "bastion_instance_monitoring" {
  type        = bool
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "bastion_instance_ebs_optimized" {
  type        = bool
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "bastion_private_ip" {
  description = "The private ip of bastion host"
  type        = string
  default     = "default"
}

variable "env" {
  description = "The environment name"
  type        = string

}

####created_on
variable "created_on" {
  description = "creation date"
  type        = string
}

/* variable "vpc" {
  type = object({
    azs = list(string)
    public_subnets = list(string)
  })
} */

variable "subnet_ids" {
  type = list(string)
}


