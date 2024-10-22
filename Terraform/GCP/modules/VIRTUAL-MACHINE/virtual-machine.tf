resource "google_compute_instance" "virtual-machine" {
  provider            = google
  name                = var.name
  project             = var.project
  machine_type        = var.machine_type
  zone                = var.zone
  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  } 

  boot_disk {
    auto_delete = true
    device_name = var.device_name
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
      labels = {
        my_label = "value"
      }
    }
    mode = "READ_WRITE"

  }

  // Local SSD disk
  //scratch_disk {
  //  interface = "NVME"
  //}

  network_interface {
    
    access_config {
      nat_ip       = var.nat_ip
      network_tier = "PREMIUM"
    }    

    queue_count = 0
    stack_type  = var.stack_type
    subnetwork  = var.subnetwork
  }

  service_account {
    email  = var.service_account
    scopes = ["https://www.googleapis.com/auth/cloud-platform", "https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  metadata = {
    terraform = "terraform"
  }

  metadata_startup_script = ""
  
  tags = var.tags
  allow_stopping_for_update = true  
}
