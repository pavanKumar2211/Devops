#### environment Specific Variable####

variable "create_individual_horizontal_node_group" {
  description = "Decide if Node Group  to be created or not TRUE=Create FALE=Dont create"
  type        = bool
}

variable "create_secure_alb" {
  description = "Decide if additional alb to be created or not TRUE=Create FALE=Dont create"
  type        = bool
}


variable "create_rds_replica" {
  description = "Decide if RDS Replica Mainto be created or not TRUE=Create FALSE=Dont create"
  type        = bool
}

variable "create_rds_instance" {
  description = "Decide if RDS Main Instance to be created or not TRUE=Create FALSE=Dont create"
  type        = bool
}

variable "create_rds_replica_cms" {
  description = "Decide if RDS Replica CMS to be created or not TRUE=Create FALSE=Dont create"
  type        = bool
}

variable "create_rds_instance_cms" {
  description = "Decide if RDS CMS Instance to be created or not TRUE=Create FALSE=Dont create"
  type        = bool
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
#### VPC variables ####
variable "vpc_cidr" {
  description = "cidr block for vpc"
  type        = string

}

variable "azs" {
  type        = list(string)
  description = "availability zone for vpc "

}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)

}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)

}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "one_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your AZ"
  type        = bool
  default     = false
}

variable "create_database_subnet_group" {
  description = "Controls if database subnet group should be created (n.b. database_subnets must also be set)"
  type        = bool
  default     = true
}

##### varibles for security groups ####




#variable for EC2 instance - bastion host

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





#set skip_final_snapshot variable to flase in production
variable "rds_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  type        = bool
  default     = true
}

variable "rds_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string

}

variable "rds_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string

}
variable "rds_port" {
  description = "The port on which the DB accepts connections"
  type        = string

}

variable "rds_username" {
  description = "Username for the master DB user"
  type        = string

}

variable "rds_availability_zone" {
  description = "Availabiltiy zone for rds"
  type        = string

}


variable "rds_storage_type" {
  type        = string
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."

}

variable "rds_max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number

}

variable "rds_create_monitoring_role" {
  type        = bool
  description = "(optional) describe your variable"
  default     = false
}

variable "rds_monitoring_interval" {
  type        = number
  description = "(optional) describe your variable"

}

variable "rds_multi_az" {
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}

variable "rds_deletion_protection" {
  type        = bool
  description = "The database can't be deleted when this value is set to true."
  default     = true
}

variable "rds_backup_retention_period" {
  type        = number
  description = "Specifies Number of days backup should be retained for"
  default     = 7
}



variable "eks_cluster_version_new" {
  type    = string
  description = "New EKS cluster version"
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



## node group app blue
variable "node_group_app_blue_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
}

variable "node_group_app_blue_max_capacity_new" {
  type        = number
  description = "Max number of workers"
}

variable "node_group_app_blue_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
}

variable "node_group_app_green_instance_type_new" {
  type        = string
  description = "Workers' instance type"
}

variable "node_group_app_disk_size_new" {
  type        = number
  description = "Workers' disk size"
}

variable "node_group_app_common_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
}

variable "node_group_app_common_max_capacity_new" {
  type        = number
  description = "Max number of workers"
}

variable "node_group_app_common_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
}

variable "node_group_app_green_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
}

variable "node_group_app_green_max_capacity_new" {
  type        = number
  description = "Max number of workers"
}

variable "node_group_app_green_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
}

variable "node_group_app_common_instance_type_new" {
  type        = string
  description = "Workers' instance type"
}

variable "node_group_app_blue_instance_type_new" {
  type        = string
  description = "Workers' instance type"
}


##node_group_horizontal

variable "node_group_horizontal_instance_type_new" {
  type        = string
  description = "Workers' instance type"
}

variable "node_group_horizontal_disk_size_new" {
  type        = number
  description = "Workers' disk size"
}

# variable "node_group_ami_release_version_new" {
#  type        = string
#  description = "new node group ami release version"
#  default     = "1.21.5-20211206"
#}

variable "node_group_horizontal_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
}

variable "node_group_horizontal_max_capacity_new" {
  type        = number
  description = "Max number of workers"
}

variable "node_group_horizontal_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
}



## EKS cluster name

variable "eks_cluster_name" {
  type = string
  description = "EKS 1.23 cluster name"
}