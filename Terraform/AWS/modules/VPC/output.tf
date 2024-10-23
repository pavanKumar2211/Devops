output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "azs" {
  value = module.vpc.azs
}

output "default_security_group_id_for_vpc" {
  value = module.vpc.default_security_group_id
}

output "igw_arn" {
  value = module.vpc.igw_arn
}

output "igw_id" {
  value = module.vpc.igw_id
}

output "vpc_name" {
  value = module.vpc.name
}

output "nat_ids" {
  value = module.vpc.nat_ids
}

output "nat_public_ips" {
  value = module.vpc.nat_public_ips
}

output "natgw_ids" {
  value = module.vpc.natgw_ids
}

output "private_subnet_arns" {
  value = module.vpc.private_subnet_arns
}

output "private_subnets_lists" {
  value = module.vpc.private_subnets
}

output "public_subnets_list" {
  value = module.vpc.public_subnets
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  value = module.vpc.public_subnets_cidr_blocks
}

