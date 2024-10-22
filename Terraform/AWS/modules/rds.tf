#######################*******RDS MAIN******###################################
module "rds-sql" {
  source                    = "terraform-aws-modules/rds/aws"
  version                   = "2.18.0"
  identifier                = "${var.env}-db"
  instance_class            = var.rds_instance_class
  username                  = var.rds_username
  password                  = var.rds_password
  port                      = var.rds_port
  vpc_security_group_ids    = [module.sg-mysql.this_security_group_id,module.sg-mysql-cdp.this_security_group_id]
  
  engine                    = var.engine
  allocated_storage         = var.allocated_storage
  engine_version            = var.engine_version

  backup_window             = var.rds_backup_window
  multi_az                  = var.rds_multi_az
  availability_zone         = var.rds_availability_zone
# Backups are required in order to create a replica
  backup_retention_period   = var.rds_backup_retention_period
# DB subnet group
  subnet_ids                = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
  #subnet_ids                = [module.vpc.private_subnets[0],module.vpc.private_subnets[1],module.vpc.private_subnets[2]]
  tags = {
     name         = "${var.env}-db-instance"
     environment  = var.env
     "created by" = "terraform"
     "created on" = "${var.created_on}"
    }
  create_db_option_group    = false
  create_db_parameter_group = false

  name     = "trial"

  storage_type              = var.rds_storage_type
  max_allocated_storage     = var.rds_max_allocated_storage
  family                    = var.rds_family

  #name     = "demodb"
  #final_snapshot_identifier = "${var.env}-db-final-snapshot"
  maintenance_window        = var.rds_maintenance_window

  #skip_final_snapshot       = var.rds_skip_final_snapshot
  apply_immediately         = true
  #create_monitoring_role    = var.rds_create_monitoring_role
  #monitoring_interval       = var.rds_monitoring_interval
  #monitoring_role_name      = "${var.env}-rds-monitoring-role"
  deletion_protection       = var.rds_deletion_protection

  #Conditional creation
    # Disable creation of RDS instance(s)
  create_db_instance = var.create_rds_instance
}

######################****RDS Read Replica MAIN****##########################

module "rds-replica" {
  source                    = "terraform-aws-modules/rds/aws"
  identifier                = "${var.env}-db-replica"
  engine_version            = var.engine_version
  backup_window             = var.backup_window
  instance_class            = var.instance_class
  engine                    = var.engine
  port                      = var.port
  maintenance_window        = var.maintenance_window
  allocated_storage         = var.allocated_storage
  # Source database. For cross-region use this_db_instance_arn
  replicate_source_db       = module.rds-sql.this_db_instance_id
  max_allocated_storage     = var.rds_max_allocated_storage
  username                  = var.rds_username
  password                  = var.rds_password
  vpc_security_group_ids    = [module.sg-mysql.this_security_group_id]
  availability_zone         = "ap-south-1a"
  # disable backups to create DB faster
  backup_retention_period = 0
  # Not allowed to specify a subnet group for replicas in the same region
  create_db_subnet_group = false

  create_db_option_group    = false
  create_db_parameter_group = false
  tags = {
    name         = "${var.env}-db-1-replica-1"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }

  version                   = "2.18.0"

  #final_snapshot_identifier = "${var.env}-db-replica-final-snapshot"
  #skip_final_snapshot       = var.rds_replica_skip_final_snapshot
  apply_immediately         = true
  #subnet_ids                = module.vpc.private_subnets

  deletion_protection       = var.rds_deletion_protection
  #Conditional creation
     #Disable creation of RDS instance(s)
  create_db_instance = var.create_rds_replica
}
