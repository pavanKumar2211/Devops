provider "aws" {
  region      = var.region
  access_key  = var.access_key
  secret_key  = var.secret_key
}

terraform {  
  backend "s3" {
    bucket = "stateterraform-bucket"
    key    = "state_dir/terraform.tfstate"
    region = "us-east-1"
  }
}

module "module" {
  source = "../../modules"
  env    = var.env
  environment = var.environment
  #label_env    = var.label_env
  created_on=var.created_on
  create_individual_node_group = var.create_individual_node_group
  create_secure_alb                   = var.create_secure_alb
  create_rds_instance                = var.create_rds_instance
  create_rds_replica                 = var.create_rds_replica
  vpc_cidr                            = var.vpc_cidr
  azs                                 = var.azs
  private_subnets                     = var.private_subnets
  public_subnets                      = var.public_subnets
  rds_family                          = var.rds_family
  rds_maintenance_window              = var.rds_maintenance_window
  rds_backup_window                   = var.rds_backup_window
  enable_nat_gateway                  = var.enable_nat_gateway
  single_nat_gateway                  = var.single_nat_gateway
  one_nat_gateway                     = var.one_nat_gateway
  create_database_subnet_group        = var.create_database_subnet_group
  bastion_ami                         = var.bastion_ami
  bastion_associate_public_ip_address = var.bastion_associate_public_ip_address
  bastion_instance_type               = var.bastion_instance_type
  bastion_key_name                    = var.bastion_key_name
  bastion_tenancy                     = var.bastion_tenancy
  bastion_instance_monitoring         = var.bastion_instance_monitoring
  bastion_instance_ebs_optimized      = var.bastion_instance_ebs_optimized
  eks_cluster_version                 = var.eks_cluster_version

  node_group_disk_size              = var.node_group_disk_size
  node_group_instance_type          = var.node_group_instance_type
  node_group_desired_capacity       = var.node_group_desired_capacity
  node_group_max_capacity           = var.node_group_max_capacity
  node_group_min_capacity           = var.node_group_min_capacity

  rds_skip_final_snapshot             = var.rds_skip_final_snapshot
  rds_instance_class                  = var.rds_instance_class
  engine                              = var.engine
  engine_version                      = var.engine_version
  allocated_storage                   = var.allocated_storage
  port                                = var.port
  instance_class                      = var.instance_class
  backup_window                       = var.backup_window
  maintenance_window                  = var.maintenance_window
  rds_password                        = var.rds_password
  rds_port                            = var.rds_port
  rds_username                        = var.rds_username
  rds_availability_zone               = var.rds_availability_zone
  rds_storage_type                    = var.rds_storage_type
  rds_max_allocated_storage           = var.rds_max_allocated_storage
  rds_create_monitoring_role          = var.rds_create_monitoring_role
  rds_monitoring_interval             = var.rds_monitoring_interval
  rds_multi_az                        = var.rds_multi_az
  rds_deletion_protection             = var.rds_deletion_protection
  rds_backup_retention_period         = var.rds_backup_retention_period


  creation_date                   = var.creation_date

  

}
