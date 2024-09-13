# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_project" "service_project" {
	project_id    =  var.data_project_id
}


module "gke_cluster" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                    = "28.0.0"
  project_id                 = var.gke_cluster[count.index].project_id
  count                      = length(var.gke_cluster)
  name                       = var.gke_cluster[count.index].name
  region                     = var.gke_cluster[count.index].region
  zones                      = var.gke_cluster[count.index].zones
  network                    = var.gke_cluster[count.index].vpc.vpc_name
  subnetwork                 = var.gke_cluster[count.index].vpc.vpc_subnet
  ip_range_pods              = var.gke_cluster[count.index].ip_range_pods
  ip_range_services          = var.gke_cluster[count.index].ip_range_services
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  regional                   = false
  filestore_csi_driver       = var.gke_cluster[count.index].filestore_csi_driver
  node_pools                 = var.gke_cluster[count.index].node_pools 
  node_pools_labels          = var.gke_cluster[count.index].node_pools_labels
  node_pools_metadata        = var.gke_cluster[count.index].node_pools_metadata 
  node_pools_tags            = var.gke_cluster[count.index].node_pools_tags
  master_ipv4_cidr_block     = var.gke_cluster[count.index].master_ipv4_cidr_block
  enable_private_endpoint    = var.gke_cluster[count.index].enable_private_endpoint
  enable_private_nodes       = var.gke_cluster[count.index].enable_private_nodes
  #cluster_autoscaling        = var.gke_cluster[count.index].cluster_autoscaling
}


