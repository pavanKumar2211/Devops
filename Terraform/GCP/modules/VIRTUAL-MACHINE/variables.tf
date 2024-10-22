variable "name" {
  type = string
}

variable "project" {
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
    type = string
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
    type = string
    default = "PREMIUM"
}

variable "stack_type" {
    type = string
    description = "The stack_type for  network_interface"
    default = "IPV4_ONLY"
}

variable "subnetwork" {
    type = string
    description = "The subnetwork for the network_interface"
}


variable "tags" {
    type = list(string)
}


variable "nat_ip" {
    type = string
}
