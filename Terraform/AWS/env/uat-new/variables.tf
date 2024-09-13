#### Environment Specific Variable####

variable "create_individual_horizontal_node_group" {
  description = "Decide if Node Group  to be created or not TRUE=Create FALSE=Dont create"
  type        = bool
  default     = false
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

variable "create_rds_replica_cms" {
  description = "Decide if RDS Replica CMS to be created or not TRUE=Create FALSE=Dont create"
  type        = bool
  default     = false
}

variable "create_rds_instance_cms" {
  description = "Decide if RDS CMS Instance to be created or not TRUE=Create FALSE=Dont create"
  type        = bool
  default     = false
}



variable "env" {
  description = "The environment name"
  type        = string
  default     = ""
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
  default     = "2021-01-14"
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

##### varibles for security groups ####




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
  default = "1.21"
}


variable "node_group_ami_release_version" {
  type        = string
  description = "node group ami release version"
  default     =  "1.21.5-20211206"
}

#eks-node-app-green  **GREEN** ################################################################
#####module doesn't allow to update desired size
variable "node_group_app_green_desired_capacity" {
  type        = number
  description = "Desired number of workers"
  default     = 1
}

variable "node_group_app_green_max_capacity" {
  type        = number
  description = "Max number of workers"
  default     = 3
}

variable "node_group_app_green_min_capacity" {
  type        = number
  description = "Mininum number of workers"
  default     = 1
}

variable "node_group_app_green_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.xlarge"
}
#node_group_app  **COMMON** ################################################################
#####module doesn't allow to update desired size
variable "node_group_app_common_desired_capacity" {
  type        = number
  description = "Desired number of workers"
  default     = 1
}

variable "node_group_app_common_max_capacity" {
  type        = number
  description = "Max number of workers"
  default     = 1
}

variable "node_group_app_common_min_capacity" {
  type        = number
  description = "Mininum number of workers"
  default     = 1
}

variable "node_group_app_common_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "c5a.2xlarge"
}
#node_group_app  **BLUE** ################################################################
variable "node_group_app_key_name" {
  type        = string
  description = "Key name for bastion_server_kporkers. Set to empty string to disable remote access"
  default     = "devops-uat-gen-kp"
}

variable "node_group_app_disk_size" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}
##doesn't allow modification once created
variable "node_group_app_blue_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.xlarge"
}

variable "node_group_app_ami_type" {
  type        = string
  description = "AMI Type. Check AWS docs"
  default     = "AL2_x86_64"
}


#####module doesn't allow to update desired size
variable "node_group_app_blue_desired_capacity" {
  type        = number
  description = "Desired number of workers"
  default     = 15
}

variable "node_group_app_blue_max_capacity" {
  type        = number
  description = "Max number of workers"
  default     = 15
}

variable "node_group_app_blue_min_capacity" {
  type        = number
  description = "Mininum number of workers"
  default     = 15
}

variable "node_group_app_iam_role" {
  type        = string
  description = "IAM ROLE"
  default     = "arn:aws:iam::811454692736:role/eksworkernoderole"
}

#node_group_mongodb ##################################################################
variable "node_group_mongodb_key_name" {
  type        = string
  description = "Key name for bastion_server_kporkers. Set to empty string to disable remote access"
  default     = "devops-uat-gen-kp"
}

variable "node_group_mongodb_disk_size" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_mongodb_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.large"
}

variable "node_group_mongodb_ami_type" {
  type        = string
  description = "AMI Type. Check AWS docs"
  default     = "AL2_x86_64"
}

variable "node_group_mongodb_desired_capacity" {
  type        = number
  description = "Desired number of workers"
  default     = 2
}

variable "node_group_mongodb_max_capacity" {
  type        = number
  description = "Max number of workers"
  default     = 2
}

variable "node_group_mongodb_min_capacity" {
  type        = number
  description = "Mininum number of workers"
  default     = 2
}

variable "node_group_mongodb_iam_role" {
  type        = string
  description = "IAM ROLE"
  default     = "arn:aws:iam::811454692736:role/eksworkernoderole"
}


#node_group_elk
variable "node_group_elk_key_name" {
  type        = string
  description = "Key name for bastion_server_kporkers. Set to empty string to disable remote access"
  default     = "devops-qa-gen-N-Virginia"
}

variable "node_group_elk_disk_size" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_elk_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.large"
}

variable "node_group_elk_ami_type" {
  type        = string
  description = "AMI Type. Check AWS docs"
  default     = "AL2_x86_64"
}

variable "node_group_elk_desired_capacity" {
  type        = number
  description = "Desired number of workers"
  default     = 1
}

variable "node_group_elk_max_capacity" {
  type        = number
  description = "Max number of workers"
  default     = 1
}

variable "node_group_elk_min_capacity" {
  type        = number
  description = "Mininum number of workers"
  default     = 1
}

variable "node_group_elk_iam_role" {
  type        = string
  description = "IAM ROLE"
  default     = "arn:aws:iam::811454692736:role/eksworkernoderole"
}

#node_group_solr
variable "node_group_solr_key_name" {
  type        = string
  description = "Key name for bastion_server_kporkers. Set to empty string to disable remote access"
  default     = "devops-qa-gen-N-Virginia"
}

variable "node_group_solr_disk_size" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_solr_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.large"
}

variable "node_group_solr_ami_type" {
  type        = string
  description = "AMI Type. Check AWS docs"
  default     = "AL2_x86_64"
}

variable "node_group_solr_desired_capacity" {
  type        = number
  description = "Desired number of workers"
  default     = 2
}

variable "node_group_solr_max_capacity" {
  type        = number
  description = "Max number of workers"
  default     = 2
}

variable "node_group_solr_min_capacity" {
  type        = number
  description = "Mininum number of workers"
  default     = 2
}

variable "node_group_solr_iam_role" {
  type        = string
  description = "IAM ROLE"
  default     = "arn:aws:iam::811454692736:role/eksworkernoderole"
}


#node_group_kafka
variable "node_group_kafka_key_name" {
  type        = string
  description = "Key name for bastion_server_kporkers. Set to empty string to disable remote access"
  default     = "devops-qa-gen-N-Virginia"
}

variable "node_group_kafka_disk_size" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_kafka_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.large"
}

variable "node_group_kafka_ami_type" {
  type        = string
  description = "AMI Type. Check AWS docs"
  default     = "AL2_x86_64"
}

variable "node_group_kafka_desired_capacity" {
  type        = number
  description = "Desired number of workers"
  default     = 3
}

variable "node_group_kafka_max_capacity" {
  type        = number
  description = "Max number of workers"
  default     = 3
}

variable "node_group_kafka_min_capacity" {
  type        = number
  description = "Mininum number of workers"
  default     = 3
}

variable "node_group_kafka_iam_role" {
  type        = string
  description = "IAM ROLE"
  default     = "arn:aws:iam::811454692736:role/eksworkernoderole"
}

#node_group_arangodb
variable "node_group_arangodb_key_name" {
  type        = string
  description = "Key name for bastion_server_kporkers. Set to empty string to disable remote access"
  default     = "devops-uat-gen-kp"
}

variable "node_group_arangodb_disk_size" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_arangodb_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.large"
}

variable "node_group_arangodb_ami_type" {
  type        = string
  description = "AMI Type. Check AWS docs"
  default     = "AL2_x86_64"
}

variable "node_group_arangodb_desired_capacity" {
  type        = number
  description = "Desired number of workers"
  default     = 2
}

variable "node_group_arangodb_max_capacity" {
  type        = number
  description = "Max number of workers"
  default     = 2
}

variable "node_group_arangodb_min_capacity" {
  type        = number
  description = "Mininum number of workers"
  default     = 2
}

variable "node_group_arangodb_iam_role" {
  type        = string
  description = "IAM ROLE"
  default     = "arn:aws:iam::811454692736:role/eksworkernoderole"
}


#node_group_horizontal
variable "node_group_horizontal_key_name" {
  type        = string
  description = "Key name for bastion_server_kporkers. Set to empty string to disable remote access"
  default     = "devops-uat-gen-kp"
}

variable "node_group_horizontal_disk_size" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_horizontal_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.large"
}

variable "node_group_horizontal_ami_type" {
  type        = string
  description = "AMI Type. Check AWS docs"
  default     = "AL2_x86_64"
}

variable "node_group_horizontal_desired_capacity" {
  type        = number
  description = "Desired number of workers"
  default     = 7
}

variable "node_group_horizontal_max_capacity" {
  type        = number
  description = "Max number of workers"
  default     = 7
}

variable "node_group_horizontal_min_capacity" {
  type        = number
  description = "Mininum number of workers"
  default     = 7
}

variable "node_group_horizontal_iam_role" {
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
  default     = "root"
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

############ RDS CMS Variable #################

#variables for RDS instance - mysql

variable "rds_allocated_storage_cms" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = "100"
}

variable "rds_max_allocated_storage_cms" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = "1000"
}

variable "rds_engine_cms" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "rds_engine_version_cms" {
  description = "The engine version to use"
  type        = string
  default     = "8.0.26"
}

variable "rds_major_engine_version_cms" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = "8.0"
}

variable "rds_instance_class_cms" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.r5.xlarge"
}

variable "rds_username_cms" {
  description = "Username for the master DB user"
  type        = string
  default     = "root"
}

variable "rds_password_cms" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  default     = "Ivsi7BeRO5u2BGrX7t"
}


######################################################

# variables for RDS - db replica

variable "rds_replica_allocated_storage_cms" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = "100"
}

variable "rds_replica_engine_cms" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "rds_replica_engine_version_cms" {
  description = "The engine version to use"
  type        = string
  default     = "8.0.26"
}

variable "rds_replica_major_engine_version_cms" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = "8.0"
}

variable "rds_replica_instance_class_cms" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.r5.xlarge"
}

########### ALB ################

variable "target_groups_name_prefix" {
  type        = string
  description = "(optional) describe your variable"
  default     = "dev-"
}

variable "target_groups_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "k8s-dashboard"
}
variable "target_type" {
  type        = string
  description = "(optional) describe your variable"
  default     = "instance"
} 
variable "target_port"{
  type        = number
  description = "(optional) describe your variable"
  default     = 80
}
variable "target_protocol"{
  type        = string
  description = "(optional) describe your variable"
  default     = "HTTP"
}
variable "certificate_arn" {
  type        = string
  description = "certificate_arn"
  default     = "xyz"
}


######################################################


variable "access_key" {
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
  
}

####### Lambda function variable


variable "lambda_region" {
  type        = string
  description = "lambda function region"
  default     = "ap-south-1"
}


variable "source_account" {
  type        = string
  description = "account_id"
  default     = "811454692736"
}

variable "lambda_handler" {
  type        = string
  description = "handler name for lambda function"
  default     = "com.fnp.bulkimport.BulkImportLambdaHandler"
}

variable "lambda_runtime" {
  type        = string
  description = "runtime env for lambda"
  default     = "java11"
}

variable "lambda_memory_size" {
  type        = number
  description = "memory_size for lambda"
  default     = 512
}

variable "lambda_timeout" {
  type        = number
  description = "timeout for lambda"
  default     = 120
}

variable "kafka_service_port" {
  type        = number
  description = "kafka service port"
  default     = 9094
}

variable "kafka_nodeport_for_nlb_tg" {
  type        = number
  description = "node port of kafka service"
  default     = 30083
}

variable "shopping_cart_lambda_handler" {
  type        = string
  description = "handler name for lambda function"
   default     = "com.fnp.shopping-cart.shoppingcartLambdaHandler"
}

variable "s3_cdp_env" {
  description = "s3 cdp policy"
  type        = string
  default     = "arn:aws:iam::221866077160:role/EC2-Dev-Role"
} 

variable "arangodb_service_port" {
  type        = number
  description = "arangodb service port"
  default     = 8529
}

variable "arangodb_nodeport_for_nlb_tg" {
  type        = number
  description = "node port of kafka service"
  default     = 31146
}

variable "eks_cluster_version_new" {
  type    = string
  default = "1.23"
}

variable "creation_date" {
  description = "creation date"
  type        = string
  default     = "2022-11-08"
}

variable "node_group_ami_release_version_new" {
  type        = string
  description = "node group ami release version"
  default     =  "1.23.9-20221104"
}


variable "node_group_horizontal_instance_type_new" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.2xlarge"
}

variable "node_group_horizontal_disk_size_new" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_horizontal_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
  default     = 3
}

variable "node_group_horizontal_max_capacity_new" {
  type        = number
  description = "Max number of workers"
  default     = 3
}

variable "node_group_horizontal_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
  default     = 3
}

variable "node_group_arangodb_instance_type_new" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.large"
}

variable "node_group_arangodb_disk_size_new" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_arangodb_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
  default     = 2
}

variable "node_group_arangodb_max_capacity_new" {
  type        = number
  description = "Max number of workers"
  default     = 2
}

variable "node_group_arangodb_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
  default     = 2
}

variable "node_group_mongodb_instance_type_new" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.xlarge"
}

variable "node_group_mongodb_disk_size_new" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_mongodb_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
  default     = 2
}

variable "node_group_mongodb_max_capacity_new" {
  type        = number
  description = "Max number of workers"
  default     = 2
}

variable "node_group_mongodb_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
  default     = 2
}

variable "node_group_apache_solr_disk_size_new" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}


variable "node_group_apache_solr_instance_type_new" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.xlarge"
}

variable "node_group_app_blue_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
  default     = 4
}

variable "node_group_app_blue_max_capacity_new" {
  type        = number
  description = "Max number of workers"
  default     = 4
}

variable "node_group_app_blue_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
  default     = 4
}

variable "node_group_app_green_instance_type_new" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.xlarge"
}

variable "node_group_app_disk_size_new" {
  type        = number
  description = "Workers' disk size"
  default     = 80
}

variable "node_group_app_common_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
  default     = 1
}

variable "node_group_app_common_max_capacity_new" {
  type        = number
  description = "Max number of workers"
  default     = 1
}

variable "node_group_app_common_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
  default     = 1
}

variable "node_group_app_green_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
  default     = 1
}

variable "node_group_app_green_max_capacity_new" {
  type        = number
  description = "Max number of workers"
  default     = 1
}

variable "node_group_app_green_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
  default     = 1
}

variable "node_group_app_common_instance_type_new" {
  type        = string
  description = "Workers' instance type"
  default     = "c5a.2xlarge"
}

variable "node_group_apache_solr_desired_capacity_new" {
  type        = number
  description = "Desired number of workers"
  default     = 2
}

variable "node_group_apache_solr_max_capacity_new" {
  type        = number
  description = "Max number of workers"
  default     = 2
}

variable "node_group_apache_solr_min_capacity_new" {
  type        = number
  description = "Mininum number of workers"
  default     = 2
}

variable "node_group_app_blue_instance_type_new" {
  type        = string
  description = "Workers' instance type"
  default     = "m5a.4xlarge"
}

variable "node_group_deliverydate_instance_type" {
  type        = string
  description = "Workers' instance type"
  default     = "r5a.2xlarge"
}

variable "node_group_deliverydate_desired_capacity" {
  type        = string
  description = "Workers' instance type"
  default     = 1
}

variable "node_group_deliverydate_max_capacity" {
  type        = string
  description = "Workers' instance type"
  default     = 1
}

variable "node_group_deliverydate_min_capacity" {
  type        = string
  description = "Workers' instance type"
  default     = 1
}

# variable "node_group_deliverydate_ami_release_version" {
#   type        = string
#   description = "EKS nodegroup AMI release version"
#   default     = "1.23.9-20220926"
# } 

variable "node_group_deliverydate_disk_size" {
  type        = string
  description = "EKS node deliverydate-disk size"
  default     = 80
} 
