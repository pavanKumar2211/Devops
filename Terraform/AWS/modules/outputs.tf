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



#############################################################################

#Security group outputs

output "bastion_security_group_name" {
  value = module.sg-bastion-ssh.this_security_group_name
}

output "bastion_security_group_id" {
  value = module.sg-bastion-ssh.this_security_group_id
}



##############

output "bastion_to_eks_security_group_name" {
  value = module.sg-bastion-ssh.this_security_group_name
}

output "all_from_bastion_ssh" {
  value = module.sg-all-from-bastion-ssh.this_security_group_id
}


#############

output "mysql_security_group_name" {
  value = module.sg-mysql.this_security_group_name
}

output "mysql_security_group_id" {
  value = module.sg-mysql.this_security_group_id
}


############

output "alb_security_group_name" {
  value = module.sg-alb.this_security_group_name
}

output "alb_security_group_id" {
  value = module.sg-alb.this_security_group_id
}

output "sg_all_from_alb" {
  value = module.sg-all-from-alb.this_security_group_name
}

output "sg-all-from-alb" {
  value = module.sg-all-from-alb.this_security_group_id
}
##############################################################################

#EC2 - Bastion

output "bastion_host_arn" {
  value = module.ec2-bastion.arn
}

output "bastion_host_id" {
  value = module.ec2-bastion.id
}

output "bastion_host_availability_zone" {
  value = module.ec2-bastion.availability_zone
}

output "bastion_host_key_name" {
  value = module.ec2-bastion.key_name
}

output "bastion_host_private_ip" {
  value = module.ec2-bastion.private_ip
}

output "bastion_host_public_dns" {
  value = module.ec2-bastion.public_dns
}

output "bastion_host_public_ip" {
  value = module.ec2-bastion.public_ip
}

output "bastion_host_security_group" {
  value = module.ec2-bastion.security_groups
}

####################################################################

#rds

output "db_instance_address" {
  value = module.rds-sql.this_db_instance_address
}

output "db_instance_id" {
  value = module.rds-sql.this_db_instance_id
}

output "db_instance_arn" {
  value = module.rds-sql.this_db_instance_arn
}

output "db_instance_availability_zone" {
  value = module.rds-sql.this_db_instance_availability_zone
}

output "db_instance_domain_id" {
  value = module.rds-sql.this_db_instance_domain
}


output "db_instance_domain_iam_role_name" {
  value = module.rds-sql.this_db_instance_domain_iam_role_name
}

output "db_instance_endpoint" {
  value = module.rds-sql.this_db_instance_endpoint
}

output "db_instance_name" {
  value = module.rds-sql.this_db_instance_name
}

output "db_instance_port" {
  value = module.rds-sql.this_db_instance_port
}

output "db_instance_status" {
  value = module.rds-sql.this_db_instance_status
}

output "db_instance_username" {
  value = module.rds-sql.this_db_instance_username
}


####################################################################
#EKS

output "eks_cluster_arn" {
  value = aws_eks_cluster.eks-cluster.arn
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "eks_cluster_iam_role_name" {
  value = aws_eks_cluster.eks-cluster.role_arn
}

output "eks_cluster_id" {
  value = aws_eks_cluster.eks-cluster.id
}

/*output "eks_cluster_sg" {
  value = aws_eks_cluster.eks-cluster.primary_security_group_id
  value = module.eks.cluster_primary_security_group_id
}*/

/*output "eks_cluster_additional_sg" {
  value = aws_eks_cluster.eks-cluster.security_group_id
}*/

output "eks_cluster_version" {
  value = aws_eks_cluster.eks-cluster.version
}

/*utput "eks_cluster-kubeconfig_content" {
  //value = aws_eks_cluster.eks-cluster.kubeconfig
  value = aws_eks_cluster.eks-cluster.local.kubeconfig
}*/

/*output "eks_cluster_kubectl_filename" {
  value = data.aws_eks_cluster
  .certificate_authority[0].data
}*/

/*output "eks_cluster_node_group_details" {
  value = aws_eks_node_group.eks-cluster.eks-node_groups
}*/


output "eks_node_group_app_autoscaling_groups_name" {
  //value = module.eks.node_groups.node-group-app.resources[0].autoscaling_groups[0].name
  value = aws_eks_node_group.eks-node-group.resources[0].autoscaling_groups[0].name
}





################# New cluster ###################

####node_group_2
/*output "eks_node_group_2_autoscaling_groups_name" {
  value = module.eks.node_groups.node-group-2.resources[0].autoscaling_groups[0].name
}*/
####################################################################

####################################################################


################################alb 



#
# Outputs
#

locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system   
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-node-group-role.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
    - rolearn: ${aws_iam_role.eks-node-group-role.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
    dynamic "block_name" {
      for_each = var.create_individual_node_group  == "true" ? [1] : [0]
      content {
        - rolearn: ${aws_iam_role.eks-node-group-role.arn}
          username: system:node:{{EC2PrivateDNSName}}
          groups:
            - system:bootstrappers
            - system:nodes
      }
}
  mapUsers: |
    - userarn: ${data.aws_caller_identity.current.arn}
      username: ${element(split("/", data.aws_caller_identity.current.arn),1)}
      groups:
        - system:masters
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks-cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks-cluster.certificate_authority[0].data}
  name: ${aws_eks_cluster.eks-cluster.arn}
contexts:
- context:
    cluster: ${aws_eks_cluster.eks-cluster.arn}
    user: ${aws_eks_cluster.eks-cluster.arn}
    namespace: ${var.env}
  name: ${var.env}-context
current-context: ${var.env}-context
kind: Config
preferences: {}
users:
- name: ${aws_eks_cluster.eks-cluster.arn}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      args:
      - --region
      - ${data.aws_region.current.name}
      - eks
      - get-token
      - --cluster-name
      - ${aws_eks_cluster.eks-cluster.id}
      command: aws
      env:
      - name: AWS_PROFILE
        value: ${var.env}
KUBECONFIG
}

output "config_map_aws_auth" {
  value = local.config_map_aws_auth
}

output "kubeconfig" {
  value = local.kubeconfig
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster. On 1.14 or later, this is the 'Additional security groups' in the EKS console."
  value = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id
}

/*
output "nlb_url" {
  value = module.nlb.this_lb_dns_name
}
*/
