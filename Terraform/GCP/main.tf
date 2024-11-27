

 module "vpc-network" {
    source                 = "./modules/VPC-NETWORK"
    project_id             = var.project_id
    network                = var.network
    subnetwork             = var.subnetwork
    region                 = var.region
    ip_range_pods_name     = var.ip_range_pods_name
    ip_range_services_name = var.ip_range_services_name
    subnet_ip              = var.subnet_ip
    ip_cidr_range          = var.ip_cidr_range
    ip_cidr_range_service  = var.ip_cidr_range_service
} 


#module "vpc-network"{
#    source                 = "../../modules/VPC-NETWORK"
#    project_id             = var.project_id
#    network_name           = var.network
#    #shared_vpc_host       = var.shared_vpc_host
#}


/* module "VirtualMachine" {
	source              = "../../modules/VIRTUAL-MACHINE"
	project	            =  var.project_id
	device_name         =  var.device_name
	machine_type        =  var.machine_type
        name	            =  var.name
	zone	            =  var.zone
	image	            =  var.image
	size	            =  var.size
	type	            =  var.type
	network_tier        =  var.network_tier
	stack_type          =  var.stack_type
	subnetwork          =  var.subnetwork
        nat_ip              =  var.nat_ip
        tags                =  var.tags
} */
 
 module "cloud-nat" {
	source              =  "./modules/CLOUD-NAT"
        project_id          =  var.project_id
        network             =  var.network
        region              =  var.region
	cloud_nat_name      =  var.cloud_nat_name
} 

/* module "gke_cluster" {
	source              =  "../../modules/GKE-CLUSTER"
        gke_cluster         = var.gke_cluster
        data_project_id     = var.data_project_id
} */

module "mysql_db" {
        source                      = "./modules/MYSQL"
        db_name                     =  var.db_name
        database_version            =  var.database_version	
        project_id	            =  var.project_id
        zone                        =  var.zone
        deletion_protection_enabled =  var.deletion_protection_enabled
        deletion_protection         =  var.deletion_protection
        network                     =  var.network
	region                      =  var.region
} 

provider "google" {
  project    = "develop-environment"
  region     = "ap-south1"
  zone	     = "ap-south1-a"
}


