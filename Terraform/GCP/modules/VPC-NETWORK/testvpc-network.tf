module "vpc-network" {
  source       = "terraform-google-modules/network/google//modules/subnets"
  version      = "9.0.0"
  project_id   = var.project_id
  network_name = var.network

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
        //ip_cidr_range = "192.X.X.X/18"
        ip_cidr_range = var.ip_cidr_range
      },
      {
        range_name    = var.ip_range_services_name
        //ip_cidr_range = "192.X.X.X/18"
        ip_cidr_range = var.ip_cidr_range_service
      },
    ]
  }
}

