//for VPC-NETWORK

project_id             = "develop-environment"
network                = "devops-vpc"
subnetwork             = "devops-vpc-subnet"
region                 = "asia-south1"
ip_range_pods_name     = "ip-range-pods"
ip_range_services_name = "ip-range-services"
subnet_ip              = "10.0.0.0/16"
ip_cidr_range          = "172.31.x.x/20"
ip_cidr_range_service  = "172.3x.x.x/20"


//for virtual-machine

name         =   "kubernetes"
project      =   "develop-environment"
location     =   "asia-south1"
machine_type =   "e2-standard-2"
cpu_platform =   "Based on availability"
zone         =   "asia-south1-a"
device_name  =   "jenkins"
image        =   "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20240126"
size         =   "10"
type         =   "pd-standard"
network_tier =   "PREMIUM"
stack_type   =   "IPV4_ONLY"
#subnetwork   =   "projects/develop-environment/regions/ap-south1/subnetworks/dev-subnet-01"
nat_ip       =   "35.x.x.x"
tags         =   ["http-server", "allow-kubernetes-22"]


// cloud-nat
cloud_nat_name  =  "devops-public-nat"

// GKE-CLUSTER

gke_cluster = [
  {
  project_id                 = "develop-environment"
  name                       = "gke-cluster"
  region                     = "asia-south1"
  zones                      = ["asia-south1-a"]
  network                    = "devops-vpc"
  subnetwork                 = "devops-subnet"
  ip_range_pods              = "ip-range-pods"
  ip_range_services          = "ip-range-services"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = false
  filestore_csi_driver       = false
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "172.x.x.x/28"

  node_pools = [
    {
      name                      = "node-pool-1"
      machine_type              = "g1-small"
      node_locations            = "asia-south1-a"
      min_count                 = 0
      max_count                 = 1
      local_ssd_count           = 0
      spot                      = false
      disk_size_gb              = 20
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      logging_variant           = "DEFAULT"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = "terraform@develop-environment.iam.gserviceaccount.com"
      preemptible               = false
      initial_node_count        = 0
    },
  ]
  
  vpc  = {
     vpc_name            =   "devops-vpc"
     vpc_subnet          =   "devops-subnet"
     vpc_sec_pod         =   "ip-range-pods"
     vpc_sec_svc         =   "ip_range_services"
    
  }
  
  
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    node-pool-1 = {
      node-pool-1 = false
    }
  }

  node_pools_metadata = {
    all = {}

    node-pool-1 = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    node-pool-1 = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    node-pool-1 = [
      "node-pool-1",
    ]
  }
  
  master_authorized_networks = [{
        cidr_block = ""
        display_name = "proxy-ip"
      }]
  
  cluster_autoscaling = {
         "auto_repair": false,
         "auto_upgrade": enable,
         "enabled": false,
         "gpu_resources": [],
         "max_cpu_cores": 0,
         "max_memory_gb": 0,
         "min_cpu_cores": 0,
         "min_memory_gb": 0
  }
}
]

data_project_id    =   "develop-environment"

// mysql

database_version   =   "MYSQL_5_7"
db_name            =   "mysql-private"
deletion_protection_enabled = false
deletion_protection     =   false