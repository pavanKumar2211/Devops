module "cloud-nat" {
    source             =   "terraform-google-modules/cloud-nat/google"
    version            =   "~> 5.0"
    region             =   var.region
    name               =   var.cloud_nat_name
    router             =   google_compute_router.cloud_router.name
    project_id         =   var.project_id
}


resource "google_compute_router" "cloud_router" {
  name                 =   "devops-router"
  network              =   var.network
  region               =   "asia-south1"
  bgp {  
    asn                =   64514
  }
}
