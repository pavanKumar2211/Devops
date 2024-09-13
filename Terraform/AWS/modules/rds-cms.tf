
#######################*******RDS CMS******###################################
module "rds-sql-cms" {
  source                    = "terraform-aws-modules/rds/aws"
  version                   = "2.18.0"
  identifier                = "${var.env}-cms-db"
  engine                    = var.rds_engine_cms
  engine_version            = var.rds_engine_version_cms
  instance_class            = var.rds_instance_class_cms
  allocated_storage         = var.rds_allocated_storage_cms
  major_engine_version      = var.rds_major_engine_version_cms
  username                  = var.rds_username_cms
  password                  = var.rds_password_cms
  port                      = var.rds_port
  vpc_security_group_ids    = [module.sg-mysql.this_security_group_id]
  maintenance_window        = var.rds_maintenance_window
  backup_window             = var.rds_backup_window
  multi_az                  = var.rds_multi_az
# Backups are required in order to create a replica
  backup_retention_period   = var.rds_backup_retention_period
# DB subnet group
  subnet_ids                = module.vpc.private_subnets
  tags = {
     name         = "${var.env}-cms-db-instance"
     environment  = var.env
     "created by" = "terraform"
     "created on" = "${var.created_on}"
    }
  create_db_option_group    = false
  create_db_parameter_group = false

  name     = "trial"

  storage_type              = var.rds_storage_type
  max_allocated_storage     = var.rds_max_allocated_storage_cms
  family                    = var.rds_family

  #name     = "demodb"
  #final_snapshot_identifier = "${var.env}-cms-db-final-snapshot"
  #skip_final_snapshot       = var.rds_skip_final_snapshot
  apply_immediately         = true
  #create_monitoring_role    = var.rds_create_monitoring_role
  #monitoring_interval       = var.rds_monitoring_interval
  #monitoring_role_name      = "${var.env}-rds-monitoring-role"
  deletion_protection       = var.rds_deletion_protection

  #Conditional creation
    # Disable creation of RDS instance(s)
  create_db_instance = var.create_rds_instance_cms
}

######################****RDS Read Replica CMS****##########################

module "rds-replica-cms" {
  source                    = "terraform-aws-modules/rds/aws"
  identifier                = "${var.env}-cms-db-replica"
  # Source database. For cross-region use this_db_instance_arn
  replicate_source_db       = module.rds-sql-cms.this_db_instance_id
  max_allocated_storage     = var.rds_max_allocated_storage_cms
  engine                    = var.rds_replica_engine_cms
  engine_version            = var.rds_replica_engine_version_cms
  instance_class            = var.rds_replica_instance_class_cms
  allocated_storage         = var.rds_replica_allocated_storage_cms
  major_engine_version      = var.rds_replica_major_engine_version_cms
  username                  = var.rds_username_cms
  password                  = var.rds_password_cms
  port                      = var.rds_replica_port
  vpc_security_group_ids    = [module.sg-mysql.this_security_group_id]
  maintenance_window        = var.rds_replica_maintenance_window
  backup_window             = var.rds_replica_backup_window
  multi_az                  = var.rds_replica_multi_az
  # disable backups to create DB faster
  backup_retention_period = 0
  # Not allowed to specify a subnet group for replicas in the same region
  create_db_subnet_group = false

  create_db_option_group    = false
  create_db_parameter_group = false
  tags = {
    name         = "${var.env}-cms-db-1-replica-1"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }

  version                   = "2.18.0"
  family                    = var.rds_replica_family
  storage_type              = var.rds_replica_storage_type

  #final_snapshot_identifier = "${var.env}-cms-db-replica-final-snapshot"
  #skip_final_snapshot       = var.rds_replica_skip_final_snapshot
  apply_immediately         = true
  #subnet_ids                = module.vpc.private_subnets

  deletion_protection       = var.rds_deletion_protection
  #Conditional creation
     #Disable creation of RDS instance(s)
  create_db_instance = var.create_rds_replica_cms
}
