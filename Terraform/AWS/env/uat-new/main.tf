provider "aws" {
  region      = var.region
  access_key  = var.access_key
  secret_key  = var.secret_key
}

terraform {  
  backend "s3" {
    bucket = "fnp-terraform-state-uat-new"
    key    = "state_dir/terraform.tfstate"
    region = "us-east-1"
  }
}

module "module_uat" {
  source = "../../modules"
  env    = var.env
  environment = var.environment
  #label_env    = var.label_env
  created_on=var.created_on
  create_individual_horizontal_node_group = var.create_individual_horizontal_node_group
  create_secure_alb                   = var.create_secure_alb
  create_rds_instance                = var.create_rds_instance
  create_rds_replica                 = var.create_rds_replica
  create_rds_instance_cms            = var.create_rds_instance_cms
  create_rds_replica_cms             = var.create_rds_replica_cms
  vpc_cidr                            = var.vpc_cidr
  azs                                 = var.azs
  private_subnets                     = var.private_subnets
  public_subnets                      = var.public_subnets
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
  node_group_ami_release_version      = var.node_group_ami_release_version

  node_group_app_key_name               = var.node_group_app_key_name
  node_group_app_disk_size              = var.node_group_app_disk_size
  node_group_app_blue_instance_type     = var.node_group_app_blue_instance_type
  node_group_app_green_instance_type    = var.node_group_app_green_instance_type
  node_group_app_ami_type               = var.node_group_app_ami_type
  node_group_app_blue_desired_capacity  = var.node_group_app_blue_desired_capacity
  node_group_app_blue_max_capacity      = var.node_group_app_blue_max_capacity
  node_group_app_blue_min_capacity      = var.node_group_app_blue_min_capacity
  node_group_app_green_desired_capacity = var.node_group_app_green_desired_capacity
  node_group_app_green_max_capacity     = var.node_group_app_green_max_capacity
  node_group_app_green_min_capacity     = var.node_group_app_green_min_capacity
  node_group_app_iam_role               = var.node_group_app_iam_role


  node_group_mongodb_key_name               = var.node_group_mongodb_key_name
  node_group_mongodb_disk_size              = var.node_group_mongodb_disk_size
  node_group_mongodb_instance_type          = var.node_group_mongodb_instance_type
  node_group_mongodb_ami_type               = var.node_group_mongodb_ami_type
  node_group_mongodb_desired_capacity       = var.node_group_mongodb_desired_capacity
  node_group_mongodb_max_capacity           = var.node_group_mongodb_max_capacity
  node_group_mongodb_min_capacity           = var.node_group_mongodb_min_capacity
  node_group_mongodb_iam_role               = var.node_group_mongodb_iam_role

  node_group_elk_key_name               = var.node_group_elk_key_name
  node_group_elk_disk_size              = var.node_group_elk_disk_size
  node_group_elk_instance_type          = var.node_group_elk_instance_type
  node_group_elk_ami_type               = var.node_group_elk_ami_type
  node_group_elk_desired_capacity       = var.node_group_elk_desired_capacity
  node_group_elk_max_capacity           = var.node_group_elk_max_capacity
  node_group_elk_min_capacity           = var.node_group_elk_min_capacity
  node_group_elk_iam_role               = var.node_group_elk_iam_role

  node_group_solr_key_name               = var.node_group_solr_key_name
  node_group_solr_disk_size              = var.node_group_solr_disk_size
  node_group_solr_instance_type          = var.node_group_solr_instance_type
  node_group_solr_ami_type               = var.node_group_solr_ami_type
  node_group_solr_desired_capacity       = var.node_group_solr_desired_capacity
  node_group_solr_max_capacity           = var.node_group_solr_max_capacity
  node_group_solr_min_capacity           = var.node_group_solr_min_capacity
  node_group_solr_iam_role               = var.node_group_solr_iam_role

  node_group_kafka_key_name               = var.node_group_kafka_key_name
  node_group_kafka_disk_size              = var.node_group_kafka_disk_size
  node_group_kafka_instance_type          = var.node_group_kafka_instance_type
  node_group_kafka_ami_type               = var.node_group_kafka_ami_type
  node_group_kafka_desired_capacity       = var.node_group_kafka_desired_capacity
  node_group_kafka_max_capacity           = var.node_group_kafka_max_capacity
  node_group_kafka_min_capacity           = var.node_group_kafka_min_capacity
  node_group_kafka_iam_role               = var.node_group_kafka_iam_role

  node_group_arangodb_key_name               = var.node_group_arangodb_key_name
  node_group_arangodb_disk_size              = var.node_group_arangodb_disk_size
  node_group_arangodb_instance_type          = var.node_group_arangodb_instance_type
  node_group_arangodb_ami_type               = var.node_group_arangodb_ami_type
  node_group_arangodb_desired_capacity       = var.node_group_arangodb_desired_capacity
  node_group_arangodb_max_capacity           = var.node_group_arangodb_max_capacity
  node_group_arangodb_min_capacity           = var.node_group_arangodb_min_capacity
  node_group_arangodb_iam_role               = var.node_group_arangodb_iam_role

  node_group_horizontal_key_name               = var.node_group_horizontal_key_name
  node_group_horizontal_disk_size              = var.node_group_horizontal_disk_size
  node_group_horizontal_instance_type          = var.node_group_horizontal_instance_type
  node_group_horizontal_ami_type               = var.node_group_horizontal_ami_type
  node_group_horizontal_desired_capacity       = var.node_group_horizontal_desired_capacity
  node_group_horizontal_max_capacity           = var.node_group_horizontal_max_capacity
  node_group_horizontal_min_capacity           = var.node_group_horizontal_min_capacity
  node_group_horizontal_iam_role               = var.node_group_horizontal_iam_role

  rds_allocated_storage               = var.rds_allocated_storage
  rds_backup_window                   = var.rds_backup_window
  rds_maintenance_window              = var.rds_maintenance_window
  rds_engine                          = var.rds_engine
  rds_engine_version                  = var.rds_engine_version
  rds_family                          = var.rds_family
  rds_major_engine_version            = var.rds_major_engine_version
  rds_skip_final_snapshot             = var.rds_skip_final_snapshot
  rds_instance_class                  = var.rds_instance_class
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
  rds_replica_allocated_storage       = var.rds_replica_allocated_storage
  rds_replica_backup_window           = var.rds_replica_backup_window
  rds_replica_maintenance_window      = var.rds_replica_maintenance_window
  rds_replica_engine                  = var.rds_replica_engine
  rds_replica_engine_version          = var.rds_replica_engine_version
  rds_replica_major_engine_version    = var.rds_replica_major_engine_version
  rds_replica_skip_final_snapshot     = var.rds_replica_skip_final_snapshot
  rds_replica_instance_class          = var.rds_replica_instance_class
  rds_replica_family                  = var.rds_replica_family
  rds_replica_port                    = var.rds_replica_port
  rds_replica_storage_type            = var.rds_replica_storage_type
  rds_replica_multi_az                = var.rds_replica_multi_az
  rds_backup_retention_period         = var.rds_backup_retention_period

  rds_allocated_storage_cms           = var.rds_allocated_storage_cms
  rds_max_allocated_storage_cms       = var.rds_max_allocated_storage_cms
  rds_engine_cms                      = var.rds_engine_cms
  rds_engine_version_cms              = var.rds_engine_version_cms
  rds_major_engine_version_cms        = var.rds_major_engine_version_cms
  rds_instance_class_cms              = var.rds_instance_class_cms
  rds_username_cms                    = var.rds_username_cms
  rds_password_cms                    = var.rds_password_cms

  rds_replica_allocated_storage_cms     = var.rds_replica_allocated_storage_cms
  rds_replica_engine_cms                = var.rds_replica_engine_cms
  rds_replica_engine_version_cms        = var.rds_replica_engine_version_cms
  rds_replica_major_engine_version_cms  = var.rds_replica_major_engine_version_cms
  rds_replica_instance_class_cms        = var.rds_replica_instance_class_cms


  target_groups_name_prefix           = var.target_groups_name_prefix
  target_groups_name                  = var.target_groups_name
  target_type                         = var.target_type
  target_port                         = var.target_port
  target_protocol                     = var.target_protocol
  certificate_arn                     = var.certificate_arn

  source_account                      = var.source_account
  lambda_region                       = var.lambda_region
  lambda_handler                      = var.lambda_handler
  lambda_runtime                      = var.lambda_runtime
  lambda_memory_size                  = var.lambda_memory_size
  lambda_timeout                      = var.lambda_timeout
  kafka_service_port                  = var.kafka_service_port
  kafka_nodeport_for_nlb_tg           = var.kafka_nodeport_for_nlb_tg
  arangodb_service_port               = var.arangodb_service_port
  arangodb_nodeport_for_nlb_tg        = var.arangodb_nodeport_for_nlb_tg
  shopping_cart_lambda_handler        = var.shopping_cart_lambda_handler
  s3_cdp_env                          = var.s3_cdp_env
  
  node_group_app_common_instance_type = var.node_group_app_common_instance_type
  node_group_app_common_min_capacity  = var.node_group_app_common_min_capacity
  node_group_app_common_max_capacity  = var.node_group_app_common_max_capacity
  node_group_app_common_desired_capacity  = var.node_group_app_common_desired_capacity

  eks_cluster_version_new               = var.eks_cluster_version_new
  creation_date                   = var.creation_date

  node_group_horizontal_instance_type_new = var.node_group_horizontal_instance_type_new
  node_group_horizontal_disk_size_new = var.node_group_horizontal_disk_size_new
  node_group_horizontal_desired_capacity_new = var.node_group_horizontal_desired_capacity_new
  node_group_horizontal_max_capacity_new = var.node_group_horizontal_max_capacity_new
  node_group_horizontal_min_capacity_new = var.node_group_horizontal_min_capacity_new
  node_group_ami_release_version_new = var.node_group_ami_release_version_new

  node_group_arangodb_instance_type_new = var.node_group_arangodb_instance_type_new
  node_group_arangodb_disk_size_new = var.node_group_arangodb_disk_size_new
  node_group_arangodb_desired_capacity_new = var.node_group_arangodb_desired_capacity_new
  node_group_arangodb_max_capacity_new = var.node_group_arangodb_max_capacity_new
  node_group_arangodb_min_capacity_new = var.node_group_arangodb_min_capacity_new

  node_group_mongodb_instance_type_new = var.node_group_mongodb_instance_type_new
  node_group_mongodb_disk_size_new = var.node_group_mongodb_disk_size_new
  node_group_mongodb_desired_capacity_new = var.node_group_mongodb_desired_capacity_new
  node_group_mongodb_max_capacity_new = var.node_group_mongodb_max_capacity_new
  node_group_mongodb_min_capacity_new = var.node_group_mongodb_min_capacity_new

  node_group_app_blue_desired_capacity_new = var.node_group_app_blue_desired_capacity_new
  node_group_app_blue_min_capacity_new = var.node_group_app_blue_min_capacity_new
  node_group_app_blue_max_capacity_new = var.node_group_app_blue_max_capacity_new
  node_group_app_blue_instance_type_new = var.node_group_app_blue_instance_type_new

  node_group_app_green_instance_type_new = var.node_group_app_green_instance_type_new
  node_group_app_green_desired_capacity_new = var.node_group_app_green_desired_capacity_new
  node_group_app_green_max_capacity_new = var.node_group_app_green_max_capacity_new
  node_group_app_green_min_capacity_new = var.node_group_app_green_min_capacity_new

  node_group_apache_solr_desired_capacity_new = var.node_group_apache_solr_desired_capacity_new
  node_group_apache_solr_max_capacity_new           = var.node_group_apache_solr_max_capacity_new
  node_group_apache_solr_min_capacity_new         = var.node_group_apache_solr_min_capacity_new
  node_group_apache_solr_instance_type_new = var.node_group_apache_solr_instance_type_new

  node_group_deliverydate_instance_type       = var.node_group_deliverydate_instance_type
  node_group_deliverydate_desired_capacity    = var.node_group_deliverydate_desired_capacity
  node_group_deliverydate_max_capacity        = var.node_group_deliverydate_max_capacity
  node_group_deliverydate_min_capacity        = var.node_group_deliverydate_min_capacity
  # node_group_deliverydate_ami_release_version = var.node_group_deliverydate_ami_release_version
  node_group_deliverydate_disk_size           = var.node_group_deliverydate_disk_size
}
