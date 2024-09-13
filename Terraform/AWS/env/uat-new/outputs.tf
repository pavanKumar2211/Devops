/*
output "eks_node_group_app_autoscaling_groups_name_1" {
    value = module.module_uat.eks_node_group_app_autoscaling_groups_name
}
*/

output "vpc_id" {
  value = "${module.module_uat.vpc_id}"
}


output "vpc_cidr_block" {
  value = module.module_uat.vpc_cidr_block
}

output "azs" {
  value = module.module_uat.azs
}

output "default_security_group_id_for_vpc" {
  value = module.module_uat.default_security_group_id_for_vpc
}

output "igw_arn" {
  value = module.module_uat.igw_arn
}

output "igw_id" {
  value = module.module_uat.igw_id
}

output "vpc_name" {
  value = module.module_uat.vpc_name
}


output "nat_ids" {
  value = module.module_uat.nat_ids
}

output "nat_public_ips" {
  value = module.module_uat.nat_public_ips
}

output "natgw_ids" {
  value = module.module_uat.natgw_ids
}

output "private_subnet_arns" {
  value = module.module_uat.private_subnet_arns
}

output "private_subnets_lists" {
  value = module.module_uat.private_subnets_lists
}

output "public_subnets_list" {
  value = module.module_uat.public_subnets_list
}

output "private_subnets_cidr_blocks" {
  value = module.module_uat.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  value = module.module_uat.public_subnets_cidr_blocks
}


#############################################################################

#Security group outputs

output "bastion_security_group_name" {
  value = module.module_uat.bastion_security_group_name
}
output "bastion_security_group_id" {
  value = module.module_uat.bastion_security_group_id
}



##############

output "bastion_to_eks_security_group_name" {
  value = module.module_uat.bastion_to_eks_security_group_name
}

output "all_from_bastion_ssh" {
  value = module.module_uat.all_from_bastion_ssh
}

#############

output "mysql_security_group_id" {
  value = module.module_uat.mysql_security_group_id
}

output "postgresql_security_group_name" {
  value = module.module_uat.mysql_security_group_name
}

############

output "alb_security_group_name" {
  value = module.module_uat.alb_security_group_name
}

output "alb_security_group_id" {
  value = module.module_uat.alb_security_group_id
}


##############################################################################

#EC2 - Bastion


output "bastion_host_arn" {
  value = module.module_uat.bastion_host_arn
}

output "bastion_host_id" {
  value = module.module_uat.bastion_host_id
}

output "bastion_host_availability_zone" {
  value = module.module_uat.bastion_host_availability_zone
}

output "bastion_host_key_name" {
  value = module.module_uat.bastion_host_key_name
}

output "bastion_host_private_ip" {
  value = module.module_uat.bastion_host_private_ip
}

output "bastion_host_public_dns" {
  value = module.module_uat.bastion_host_public_dns
}

output "bastion_host_public_ip" {
  value = module.module_uat.bastion_host_public_ip
}

output "bastion_host_security_group" {
  value = module.module_uat.bastion_host_security_group
}

####################################################################

#rds

output "db_instance_address" {
  value = module.module_uat.db_instance_address
}

output "db_instance_id" {
  value = module.module_uat.db_instance_id
}

output "db_instance_arn" {
  value = module.module_uat.db_instance_arn
}

output "db_instance_availability_zone" {
  value = module.module_uat.db_instance_availability_zone
}

output "db_instance_domain_id" {
  value = module.module_uat.db_instance_domain_id
}

output "db_instance_domain_iam_role_name" {
  value = module.module_uat.db_instance_domain_iam_role_name
}

output "db_instance_endpoint" {
  value = module.module_uat.db_instance_endpoint
}

output "db_instance_name" {
  value = module.module_uat.db_instance_name
}

output "db_instance_port" {
  value = module.module_uat.db_instance_port
}

output "db_instance_status" {
  value = module.module_uat.db_instance_status
}

output "db_instance_username" {
  value = module.module_uat.db_instance_username
}


####################################################################
#EKS

output "eks_cluster_arn" {
  value = module.module_uat.eks_cluster_arn
}

output "eks_cluster_endpoint" {
  value = module.module_uat.eks_cluster_endpoint
}

output "eks_cluster_iam_role_name" {
  value = module.module_uat.eks_cluster_iam_role_name
}

output "eks_cluster_id" {
  value = module.module_uat.eks_cluster_id
}
/*
output "eks_cluster_sg" {
  value = module.module_uat.eks_cluster_sg
}

output "eks_cluster_additional_sg" {
  value = module.module_uat.eks_cluster_additional_sg
}*/

output "eks_cluster_version" {
  value = module.module_uat.eks_cluster_version
}

output "eks_cluster-kubeconfig_content" {
  value = module.module_uat.kubeconfig
}

output "eks_cluster-kubeconfig_amp_aws_auth" {
  value = module.module_uat.config_map_aws_auth
}


output "eks_cluster_sg" {
  value = module.module_uat.cluster_security_group_id
}


/*output "eks_cluster_kubectl_filename" {
  value = module.module_uat.eks_cluster_kubectl_filename
}*/

/*
output "eks_cluster_node_group_details" {
  value = module.module_uat.eks_cluster_node_group_details
}*/


output "eks_node_group_app_blue_autoscaling_groups_name" {
  value = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
}

output "eks_node_group_app_green_autoscaling_groups_name" {
  value = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
}
output "eks_node_group_app_autoscaling_groups_name_arangodb" {
  value = module.module_uat.eks_node_group_app_autoscaling_groups_name_arangodb
}

output "eks_node_group_app_autoscaling_groups_name_kibana" {
  value = module.module_uat.eks_node_group_app_autoscaling_groups_name_kibana
}

output "eks_node_group_app_autoscaling_groups_name_kafka" {
  value = module.module_uat.eks_node_group_app_autoscaling_groups_name_kafka
}

output "eks_node_group_app_autoscaling_groups_name_solr" {
  value = module.module_uat.eks_node_group_app_autoscaling_groups_name_solr
}

output "eks_node_group_app_autoscaling_groups_name_mongodb" {
  value = module.module_uat.eks_node_group_app_autoscaling_groups_name_mongodb
}

####node_group_2
/*output "eks_node_group_2_autoscaling_groups_name" {
  value = module.module_uat.eks_node_group_2_autoscaling_groups_name
}*/

####################################################################


#s3
output "bulk_data_s3_bucket_arn" {
  value = module.module_uat.bulk_data_s3_bucket_arn
}


output "bulk_data_s3_bucket_bucket_domain_name" {
  value = module.module_uat.bulk_data_s3_bucket_bucket_domain_name
}


output "bulk_data_s3_bucket_bucket_regional_domain_name" {
  value = module.module_uat.bulk_data_s3_bucket_bucket_regional_domain_name
}


output "bulk_data_s3_bucket_hosted_zone_id" {
  value = module.module_uat.bulk_data_s3_bucket_hosted_zone_id
}


output "bulk_data_s3_bucket_id" {
  value = module.module_uat.bulk_data_s3_bucket_id
}


output "bulk_data_s3_bucket_region" {
  value = module.module_uat.bulk_data_s3_bucket_region
}

########################################alb
output "alb_arn" {
  value = module.module_uat.alb_arn
}

output "secure_alb_arn" {
  value = module.module_uat.secure_alb_arn
}