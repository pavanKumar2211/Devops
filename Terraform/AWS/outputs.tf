
output "vpc_id" {
  value = "${module.vpc-module.vpc_id}"
}


output "vpc_cidr_block" {
  value = module.vpc-module.vpc_cidr_block
}

output "azs" {
  value = module.vpc-module.azs
}

output "igw_arn" {
  value = module.vpc-module.igw_arn
}

output "igw_id" {
  value = module.vpc-module.igw_id
}

output "vpc_name" {
  value = module.vpc-module.vpc_name
}


output "nat_ids" {
  value = module.vpc-module.nat_ids
}

output "nat_public_ips" {
  value = module.vpc-module.nat_public_ips
}

output "natgw_ids" {
  value = module.vpc-module.natgw_ids
}

output "private_subnet_arns" {
  value = module.vpc-module.private_subnet_arns
}

output "private_subnets_lists" {
  value = module.vpc-module.private_subnets_lists
}

output "public_subnets_list" {
  value = module.vpc-module.public_subnets_list
}

output "private_subnets_cidr_blocks" {
  value = module.vpc-module.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  value = module.vpc-module.public_subnets_cidr_blocks
}

##############################################################################

#ec2-module - Bastion


output "bastion_host_arn" {
  value = module.ec2-module.bastion_host_arn
}

output "bastion_host_id" {
  value = module.ec2-module.bastion_host_id
}

output "bastion_host_availability_zone" {
  value = module.ec2-module.bastion_host_availability_zone
}

output "bastion_host_key_name" {
  value = module.ec2-module.bastion_host_key_name
}

output "bastion_host_private_ip" {
  value = module.ec2-module.bastion_host_private_ip
}

output "bastion_host_public_dns" {
  value = module.ec2-module.bastion_host_public_dns
}

output "bastion_host_public_ip" {
  value = module.ec2-module.bastion_host_public_ip
}

####################################################################

#rds

output "db_instance_address" {
  value = module.rds-module.db_instance_address
}

output "db_instance_id" {
  value = module.rds-module.db_instance_id
}

output "db_instance_arn" {
  value = module.rds-module.db_instance_arn
}

output "db_instance_availability_zone" {
  value = module.rds-module.db_instance_availability_zone
}

output "db_instance_domain_id" {
  value = module.rds-module.db_instance_domain_id
}

output "db_instance_domain_iam_role_name" {
  value = module.rds-module.db_instance_domain_iam_role_name
}

output "db_instance_endpoint" {
  value = module.rds-module.db_instance_endpoint
}

output "db_instance_name" {
  value = module.rds-module.db_instance_name
}

output "db_instance_port" {
  value = module.rds-module.db_instance_port
}

output "db_instance_status" {
  value = module.rds-module.db_instance_status
}

output "db_instance_username" {
  value = module.rds-module.db_instance_username
}


####################################################################
#eks-module

output "eks_cluster_arn" {
  value = module.eks-module.eks_cluster_arn
}

output "eks_cluster_endpoint" {
  value = module.eks-module.eks_cluster_endpoint
}

output "eks_cluster_iam_role_name" {
  value = module.eks-module.eks_cluster_iam_role_name
}

output "eks_cluster_id" {
  value = module.eks-module.eks_cluster_id
}

output "eks_cluster_version" {
  value = module.eks-module.eks_cluster_version
}

output "eks_cluster-kubeconfig_content" {
  value = module.eks-module.kubeconfig
}

output "eks_cluster-kubeconfig_amp_aws_auth" {
  value = module.eks-module.config_map_aws_auth
}



