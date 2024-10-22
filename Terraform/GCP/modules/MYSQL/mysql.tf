module "sql-db" {
  source                       = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version                      = "18.1.0"
  db_name                      =  var.db_name
  database_version	           =  var.database_version	
  project_id	               =  var.project_id
  zone                         =  var.zone
  deletion_protection_enabled  =  var.deletion_protection_enabled
  deletion_protection          =  var.deletion_protection
  ip_configuration = {
    ipv4_enabled        = false
    private_network     = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.network}"
    require_ssl         = false
    allocated_ip_range  = null
    authorized_networks = []
  }

} 


#resource "google_compute_network" "private_network" {
#  provider = google-beta
#  name     = var.network
#  project  = var.project_id
#}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  project       = var.project_id
  network       = var.network
  
} 

resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  #project                 = var.project_id
  network                 = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.network}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
} 

resource "random_id" "db_name_suffix" {
  byte_length = 4
} 

resource "google_sql_database_instance" "instance" {
  provider = google-beta
  
  name                         = var.db_name
  region                       = var.region
  database_version             = var.database_version
  #deletion_protection_enabled = var.deletion_protection_enabled
  project                      = var.project_id
  deletion_protection          = var.deletion_protection
  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.network}"
      enable_private_path_for_google_cloud_services = true
    }
  }
} 

resource "google_sql_user" "user" {
  name     = "pavan"
  instance = google_sql_database_instance.instance.name
  password = var.password
  project  = var.project_id
  host     = var.host
  #deletion_protection =  var.deletion_protection
}


provider "google-beta" {
  region = var.region
  zone   = var.zone
}


