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



