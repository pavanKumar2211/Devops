#### Environment Specific Variable####

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "8.0.28"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.m6g.2xlarge"
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "3306"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = "50"
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "09:46-10:16"
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}


variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "create_secure_alb" {
  description = "Decide if additional alb  to be created or not TRUE=Create FALSE=Dont create"
  type        = bool
  default     = true
}

variable "create_rds_replica" {
  description = "Decide if RDS Replica Mainto be created or not TRUE=Create FALSE=Dont create"
  type        = bool
  default     = false
}

variable "create_rds_instance" {
  description = "Decide if RDS Main Instance to be created or not TRUE=Create FALSE=Dont create"
  type        = bool
  default     = true
}

variable "env" {
  description = "The environment name"
  type        = string
  default     = "uat"
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = "uat"
}
##################################
/*
variable "label_env" {
  description = "Node affinity name"
  type        = string
  default     = ""
}
*/
######################################
#####created on###########
variable "created_on" {
  description = "creation date"
  type        = string
  default     = "2024-10-23"
}
#### VPC variables ####
variable "vpc_cidr" {
  description = "cidr block for vpc"
  type        = string
  default     = "172.23.0.0/16"
}

variable "azs" {
  type        = list(string)
  description = "availability zone for vpc "
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["172.23.16.0/20", "172.23.32.0/20", "172.23.48.0/20"]
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["172.23.64.0/20", "172.23.80.0/20", "172.23.112.0/20"]

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

#variable for EC2 instance - bastion host

variable "bastion_ami" {
  description = "ID of AMI Amazon linux to use for the instance"
  type        = string
  default     = "ami-02b5fbc2cb28b77b8"
}

variable "bastion_associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = true
}

variable "bastion_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.medium"
}

variable "bastion_key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = "devops-uat-gen-kp"
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


######################################################

#EKS variables

variable "eks_cluster_version" {
  type    = string
  default = "1.28"
}


variable "node_group_ami_release_version" {
  type        = string
  description = "node group ami release version"
  default     =  "1.28.5-20211206"
}

#node_group
variable "node_group_key_name" {
  type        = string
  description = "Key name for bastion_server_kporkers. Set to empty string to disable remote access"
  default     = "devops-gen-kp"
}

variable "node_group_disk_size" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.large"
}

variable "node_group_ami_type" {
  type        = string
  description = "AMI Type. Check AWS docs"
  default     = "AL2_x86_64"
}

variable "node_group_desired_capacity" {
  type        = number
  description = "Desired number of workers"
  default     = 7
}

variable "node_group_max_capacity" {
  type        = number
  description = "Max number of workers"
  default     = 7
}

variable "node_group_min_capacity" {
  type        = number
  description = "Mininum number of workers"
  default     = 7
}

variable "node_group_iam_role" {
  type        = string
  description = "IAM ROLE"
  default     = "arn:aws:iam::811454692736:role/eksworkernoderole"
}


#########################RDS############################

#variables for RDS instance - mysql

variable "rds_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = "50"
}
variable "rds_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "09:46-10:16"
}

variable "rds_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "rds_engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "rds_availability_zone" {
  description = "Availabiltiy zone for rds"
  type        = string
  default     = "ap-south-1a"
}

variable "rds_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "8.0.28"
}

variable "rds_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "mysql8.0"
}

variable "rds_major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = "8.0"
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
  default     = "db.m6g.2xlarge"
}

variable "rds_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  default     = "fnp867uatapp"
}

variable "rds_port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "3306"
}

variable "rds_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "fnproot"
}

variable "rds_storage_type" {
  type        = string
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  default     = "gp2"
}

variable "rds_max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 2000
}

variable "rds_create_monitoring_role" {
  type        = bool
  description = "(optional) describe your variable"
  default     = false
}

variable "rds_monitoring_interval" {
  type        = number
  description = "(optional) describe your variable"
  default     = 0
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
  default     = 2
}

######################################################

#variables for RDS - db replica 

variable "rds_replica_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = "50"
}
variable "rds_replica_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "09:46-10:16"
}

variable "rds_replica_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "rds_replica_engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "rds_replica_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "8.0.23"
}

variable "rds_replica_major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = "8.0"
}

#set skip_final_snapshot variable to flase in production
variable "rds_replica_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  type        = bool
  default     = true
}

variable "rds_replica_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.large"
}

variable "rds_replica_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "mysql8.0"
}

variable "rds_replica_port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "3306"
}

variable "rds_replica_storage_type" {
  type        = string
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  default     = "gp2"
}

variable "rds_replica_multi_az" {
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}

######################################################


/* variable "access_key" {
  type        = string
  description = "access KEY"
  
}
variable "secret_key" {
  type        = string
  description = "secret key."
  
}
variable "region" {
  type        = string
  description = "region"
  
} */

variable "creation_date" {
  description = "creation date"
  type        = string
  default     = "2022-11-08"
}

## EKS cluster name

variable "eks_cluster_name" {
  type = string
  description = "EKS 1.23 cluster name"
}

variable "vpc" {
  type = object({
    private_subnets = list(string)
    public_subnets  = list(string)
  })
}


variable "subnet_ids" {
  type = list(string)
}


