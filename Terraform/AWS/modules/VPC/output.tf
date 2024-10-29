output "vpc_id" {
  value = module.VPC.vpc_id
}

output "vpc_cidr_block" {
  value = module.VPC.vpc_cidr_block
}

output "azs" {
  value = module.VPC.azs
}

output "default_security_group_id_for_vpc" {
  value = module.VPC.default_security_group_id
}

output "igw_arn" {
  value = module.VPC.igw_arn
}

output "igw_id" {
  value = module.VPC.igw_id
}

output "vpc_name" {
  value = module.VPC.name
}

output "nat_ids" {
  value = module.VPC.nat_ids
}

output "nat_public_ips" {
  value = module.VPC.nat_public_ips
}

output "natgw_ids" {
  value = module.VPC.natgw_ids
}

output "private_subnet_arns" {
  value = module.VPC.private_subnet_arns
}

output "private_subnets_lists" {
  value = module.VPC.private_subnets
}

output "public_subnets_list" {
  value = module.VPC.public_subnets
}

output "private_subnets_cidr_blocks" {
  value = module.VPC.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  value = module.VPC.public_subnets_cidr_blocks
}
