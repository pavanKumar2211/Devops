variable "vpc_cidr" {
  description = "cidr block for vpc"
  type        = string

}

variable "azs" {
  type        = list(string)
  description = "availability zone for vpc "

}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)

}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)

}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "one_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your AZ"
  type        = bool
  default     = false
}

variable "create_database_subnet_group" {
  description = "Controls if database subnet group should be created (n.b. database_subnets must also be set)"
  type        = bool
  default     = true
}


variable "env" {
  description = "The environment name"
  type        = string

}

####created_on
variable "created_on" {
  description = "creation date"
  type        = string

}