// common 


variable "project_id" {
  type = string
}


// for VPC-NETWORK

variable "network" {
    type = string
}


variable "subnetwork" {
    description = "subnet"
}


variable "region" {
   type = string
}

variable "ip_range_pods_name" { 
   type = string
}

variable "ip_range_services_name" {
   type = string
}

variable "subnet_ip" {
    type = string
}

variable "ip_cidr_range" {
    description = "subnet"
}

variable "ip_cidr_range_service" {
    type = string
}


// for virtual-machine

variable "name" {
  type = string
}

variable "project" {
  type = string
}

variable "location" {
  type = string
}

variable "machine_type" {
    type = string
}

variable "zone" {
    type = string
    description = "The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`."
}


variable "device_name" {
    type = string
}


variable "image" {
    type        = string
    description = "The Image for the VM instance"
}


variable "size" {
    description = "The disk size for the master instance."
    default     = 10
}

variable "type" {
    type = string
}

variable "network_tier" {
    type    = string
    default = "PREMIUM"
}

variable "stack_type" {
    type        = string
    description = "The stack_type for  network_interface"
    default     = "IPV4_ONLY"
}

variable "nat_ip" {
   type  = string
}

variable "tags" {
    type = list(string)
}


// cloud-nat

variable "cloud_nat_name" {
    type = string
}


//GKE-CLUSTER


variable "gke_cluster" {
	type = list(object({
            project_id                 =   string
            name                       =   string
            region                     =   string
            zones                      =   list(string)
            filestore_csi_driver       =   bool
            horizontal_pod_autoscaling =   bool            
            node_pools                  =   list(map(any))
            node_pools_labels          =   map(map(string))
            node_pools_metadata        =   map(map(string))	
            node_pools_tags            =   map(list(string))
            master_ipv4_cidr_block     =   string
            ip_range_pods              =   string
            ip_range_services          =   string            
            enable_private_endpoint    =   string
            enable_private_nodes       =   string                              
            vpc = object({
                   vpc_name            =   string
                   vpc_subnet          =   string
                   vpc_sec_pod         =   string
                   vpc_sec_svc         =   string
            })
            master_authorized_networks =   list(object({
                   cidr_block          =   string
                   display_name        =   string
            }))
            cluster_autoscaling        =   object({
                   enabled       = bool
                   min_cpu_cores = number
                   max_cpu_cores = number
                   min_memory_gb = number
                   max_memory_gb = number
                   gpu_resources = list(object({ resource_type = string, minimum = number, maximum = number }))
                   #auto_repair   = bool
                   #auto_upgrade  = bool
            })        
        }))

}


variable "data_project_id" {
    type    =  string
}

// mysql

variable "db_name" {
    type   =   string
}

variable "database_version" {
    type   =   string
}

variable "deletion_protection_enabled" {
    type   =   bool
}

variable "deletion_protection" {
    type   =   bool
}

 


