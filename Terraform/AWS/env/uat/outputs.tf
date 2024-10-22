/*
output "eks_node_group_app_autoscaling_groups_name_1" {
    value = module.module_develop.eks_node_group_app_autoscaling_groups_name
}
*/

output "vpc_id" {
  value = "${module.module_develop.vpc_id}"
}


output "vpc_cidr_block" {
  value = module.module_develop.vpc_cidr_block
}

output "azs" {
  value = module.module_develop.azs
}

output "default_security_group_id_for_vpc" {
  value = module.module_develop.default_security_group_id_for_vpc
}

output "igw_arn" {
  value = module.module_develop.igw_arn
}

output "igw_id" {
  value = module.module_develop.igw_id
}

output "vpc_name" {
  value = module.module_develop.vpc_name
}


output "nat_ids" {
  value = module.module_develop.nat_ids
}

output "nat_public_ips" {
  value = module.module_develop.nat_public_ips
}

output "natgw_ids" {
  value = module.module_develop.natgw_ids
}

output "private_subnet_arns" {
  value = module.module_develop.private_subnet_arns
}

output "private_subnets_lists" {
  value = module.module_develop.private_subnets_lists
}

output "public_subnets_list" {
  value = module.module_develop.public_subnets_list
}

output "private_subnets_cidr_blocks" {
  value = module.module_develop.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  value = module.module_develop.public_subnets_cidr_blocks
}


#############################################################################

#Security group outputs

output "bastion_security_group_name" {
  value = module.module_develop.bastion_security_group_name
}
output "bastion_security_group_id" {
  value = module.module_develop.bastion_security_group_id
}



##############

output "bastion_to_eks_security_group_name" {
  value = module.module_develop.bastion_to_eks_security_group_name
}

output "all_from_bastion_ssh" {
  value = module.module_develop.all_from_bastion_ssh
}

#############

output "mysql_security_group_id" {
  value = module.module_develop.mysql_security_group_id
}

output "postgresql_security_group_name" {
  value = module.module_develop.mysql_security_group_name
}

############

output "alb_security_group_name" {
  value = module.module_develop.alb_security_group_name
}

output "alb_security_group_id" {
  value = module.module_develop.alb_security_group_id
}


##############################################################################

#EC2 - Bastion


output "bastion_host_arn" {
  value = module.module_develop.bastion_host_arn
}

output "bastion_host_id" {
  value = module.module_develop.bastion_host_id
}

output "bastion_host_availability_zone" {
  value = module.module_develop.bastion_host_availability_zone
}

output "bastion_host_key_name" {
  value = module.module_develop.bastion_host_key_name
}

output "bastion_host_private_ip" {
  value = module.module_develop.bastion_host_private_ip
}

output "bastion_host_public_dns" {
  value = module.module_develop.bastion_host_public_dns
}

output "bastion_host_public_ip" {
  value = module.module_develop.bastion_host_public_ip
}

output "bastion_host_security_group" {
  value = module.module_develop.bastion_host_security_group
}

####################################################################

#rds

output "db_instance_address" {
  value = module.module_develop.db_instance_address
}

output "db_instance_id" {
  value = module.module_develop.db_instance_id
}

output "db_instance_arn" {
  value = module.module_develop.db_instance_arn
}

output "db_instance_availability_zone" {
  value = module.module_develop.db_instance_availability_zone
}

output "db_instance_domain_id" {
  value = module.module_develop.db_instance_domain_id
}

output "db_instance_domain_iam_role_name" {
  value = module.module_develop.db_instance_domain_iam_role_name
}

output "db_instance_endpoint" {
  value = module.module_develop.db_instance_endpoint
}

output "db_instance_name" {
  value = module.module_develop.db_instance_name
}

output "db_instance_port" {
  value = module.module_develop.db_instance_port
}

output "db_instance_status" {
  value = module.module_develop.db_instance_status
}

output "db_instance_username" {
  value = module.module_develop.db_instance_username
}


####################################################################
#EKS

output "eks_cluster_arn" {
  value = module.module_develop.eks_cluster_arn
}

output "eks_cluster_endpoint" {
  value = module.module_develop.eks_cluster_endpoint
}

output "eks_cluster_iam_role_name" {
  value = module.module_develop.eks_cluster_iam_role_name
}

output "eks_cluster_id" {
  value = module.module_develop.eks_cluster_id
}
/*
output "eks_cluster_sg" {
  value = module.module_develop.eks_cluster_sg
}

output "eks_cluster_additional_sg" {
  value = module.module_develop.eks_cluster_additional_sg
}*/

output "eks_cluster_version" {
  value = module.module_develop.eks_cluster_version
}

output "eks_cluster-kubeconfig_content" {
  value = module.module_develop.kubeconfig
}

output "eks_cluster-kubeconfig_amp_aws_auth" {
  value = module.module_develop.config_map_aws_auth
}


output "eks_cluster_sg" {
  value = module.module_develop.cluster_security_group_id
}


/*output "eks_cluster_kubectl_filename" {
  value = module.module_develop.eks_cluster_kubectl_filename
}*/

/*
output "eks_cluster_node_group_details" {
  value = module.module_develop.eks_cluster_node_group_details
}*/


####node_group_2
/*output "eks_node_group_2_autoscaling_groups_name" {
  value = module.module_develop.eks_node_group_2_autoscaling_groups_name
}*/

####################################################################






