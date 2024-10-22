variable "network" {
    type = string
}


variable "subnetwork" {
    description = "subnet"
}

variable "project_id" {
    type = string
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
