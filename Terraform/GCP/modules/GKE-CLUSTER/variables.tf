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
            #cluster_autoscaling  = object({
            #        enabled       = bool
            #         min_cpu_cores = number
            #         max_cpu_cores = number
            #         min_memory_gb = number
            #         max_memory_gb = number
            #         gpu_resources = list(object({ resource_type = string, minimum = number, maximum = number }))
            #         auto_repair   = bool
            #         auto_upgrade  = bool
            #})
        }))
}


variable "data_project_id" {
     type       =    string
}
