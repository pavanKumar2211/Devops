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

variable "allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
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

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string

}


variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
}


variable "create_rds_replica" {
  description = "Decide if RDS Replica Mainto be created or not TRUE=Create FALSE=Dont create"
  type        = bool
}

variable "create_rds_instance" {
  description = "Decide if RDS Main Instance to be created or not TRUE=Create FALSE=Dont create"
  type        = bool
}


variable "rds_family" {
  description = "The family of the DB parameter group"
  type        = string
}

variable "rds_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  }


variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string

}

variable "rds_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string

}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string

}

variable "engine" {
  description = "The database engine to use"
  type        = string

}

variable "engine_version" {
  description = "The engine version to use"
  type        = string

}
