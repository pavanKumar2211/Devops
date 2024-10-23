variable "eks_cluster_version" {
  type    = string
  description = "EKS cluster version"
}

variable "environment" {
  description = "The environment name"
  type        = string
}

variable "creation_date" {
  description = "creation date"
  type        = string
}



######################################################

#EKS variables

# variable "eks_cluster_version" {
#   type    = string

# }



##node_group

variable "node_group_instance_type" {
  type        = string
  description = "Workers' instance type"
}

variable "node_group_disk_size" {
  type        = number
  description = "Workers' disk size"
}

# variable "node_group_ami_release_version" {
#  type        = string
#  description = "node group ami release version"
#  default     = "1.29.5-20241206"
#}

variable "node_group_desired_capacity" {
  type        = number
  description = "Desired number of workers"
}

variable "node_group_max_capacity" {
  type        = number
  description = "Max number of workers"
}

variable "node_group_min_capacity" {
  type        = number
  description = "Mininum number of workers"
}



## EKS cluster name

variable "eks_cluster_name" {
  type = string
  description = "EKS 1.29 cluster name"
  default = "feature-env"
}
