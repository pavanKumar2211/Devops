module "vpc-network" {
  #source  = "terraform-google-modules/network/google"
  #version = ">= 7.5"
  
  #source  = "terraform-google-modules/network/google//modules/vpc"
  #version = ">= 9.0"
  
  source       = "terraform-google-modules/network/google//modules/vpc"
  version      = "9.0.0"
  project_id   = var.project_id
  network_name = var.network
  #subnet_ip    = google_compute_subnetwork.network-with-private-secondary-ip-ranges.ip_cidr_range
  #ip_range_services_name  = google_compute_subnetwork.network-with-private-secondary-ip-ranges.ip_range_services_name
  #subnetwork        = google_compute_subnetwork.network-with-private-secondary-ip-ranges.subnetwork
  #region             =  var.region
  #ip_range_pods_name    = var.ip_range_pods_name
  #ip_cidr_range          = var.ip_cidr_range
  #ip_cidr_range_service  = var.ip_cidr_range_service
  shared_vpc_host = false
  auto_create_subnetworks  = false
  
}


/* module "subnet" {
  #source  = "terraform-google-modules/network/google"
  #version = ">= 7.5"
  
  #source  = "terraform-google-modules/network/google//modules/vpc"
  #version = ">= 9.0"
  
  source       = "terraform-google-modules/network/google//modules/subnets"
  version      = "9.0.0"
  project_id   = var.project_id
  network_name = module.vpc-network.network

  subnets = [
    {
      subnet_name   = var.subnetwork
      //subnet_ip     = "10.0.0.0/17"
      subnet_ip     = var.subnet_ip
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    (var.subnetwork) = [
      {
        range_name    = var.ip_range_pods_name
        //ip_cidr_range = "192.168.0.0/18"
        ip_cidr_range = var.ip_cidr_range
      },
      {
        range_name    = var.ip_range_services_name
        //ip_cidr_range = "192.168.64.0/18"
        ip_cidr_range = var.ip_cidr_range_service
      },
    ]
  }
}
*/

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "devops-subnet"
  ip_cidr_range = var.subnet_ip
  region        = var.region
#  subnet_ip     = "10.0.0.0/17"
  network       = module.vpc-network.network_name
  secondary_ip_range {
    range_name    = var.ip_range_services_name
    ip_cidr_range = var.ip_cidr_range_service
  }

  secondary_ip_range {
    range_name    = var.ip_range_pods_name
    ip_cidr_range = var.ip_cidr_range
  }


}


#resource "google_compute_subnetwork" "network-with-private-secondary-ip-pod-ranges" {
#  name          = "vpc-subnetwork"
#  ip_cidr_range = var.subnet_ip
#  region        = var.region
#  subnet_ip     = "10.0.0.0/17"
#  network       = module.vpc-network.network_name
#  secondary_ip_range {
#    range_name    = var.ip_range_pods_name
#    ip_cidr_range = var.ip_cidr_range
#  }
#}





/* module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.vpc-network.network_name

  rules = [{
    name                    = "allow-kubernetes-22"
    description             = null
    direction               = "INGRESS"
    priority                = 1000
    destination_ranges      = [""]
    source_ranges           = ["35.235.240.0/20","45.249.0.0/24"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = ["allow-kubernetes-22"]
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["8080","22"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
} */
