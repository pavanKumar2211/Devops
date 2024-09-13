#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "elk-eks-node-group-role-new" {
  name =  "${var.env}-eks-node-elk-new"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "elk-eks-node-AmazonEKSWorkerNodePolicy-new" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.elk-eks-node-group-role-new.name
}

resource "aws_iam_role_policy_attachment" "elk-eks-node-AmazonEKS_CNI_Policy-new" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.elk-eks-node-group-role-new.name
}

resource "aws_iam_role_policy_attachment" "elk-eks-node-AmazonEC2ContainerRegistryReadOnly-new" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.elk-eks-node-group-role-new.name
}

resource "aws_eks_node_group" "eks-node-group-elk-new" {
  #count = var.create_individual_horizontal_node_group ? 1 : 0
  cluster_name    = aws_eks_cluster.eks-cluster-new.name
  node_group_name = "${var.env}-eks-node-elk"
  node_role_arn   = aws_iam_role.elk-eks-node-group-role-new.arn
  #subnet_ids      = module.vpc.private_subnets
  subnet_ids      = [module.vpc.private_subnets[0]]
  instance_types  = [var.node_group_elk_instance_type_new]
  disk_size       = var.node_group_elk_disk_size_new
  #release_version = var.node_group_ami_release_version_new
  scaling_config {
    desired_size = var.node_group_elk_desired_capacity_new
    max_size     = var.node_group_elk_max_capacity_new
    min_size     = var.node_group_elk_min_capacity_new
  }
  
  // Dont accept ami ID
  //ami_type                  = var.node_group_2_ami_type
   remote_access {
    ec2_ssh_key               = var.bastion_key_name
    source_security_group_ids = ["${module.sg-bastion-ssh.this_security_group_id}",aws_eks_cluster.eks-cluster-new.vpc_config[0].cluster_security_group_id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.elk-eks-node-AmazonEKSWorkerNodePolicy-new,
    aws_iam_role_policy_attachment.elk-eks-node-AmazonEKS_CNI_Policy-new,
    aws_iam_role_policy_attachment.elk-eks-node-AmazonEC2ContainerRegistryReadOnly-new,
  ]

   labels = {
        environment = var.env
        purpose = "${var.env}-elk"
      }
   tags = {
        Name      = "${var.env}-eks-node-elk"
        "kubernetes.io/cluster/eks" = "owned"
        environment  = var.env
      }
}
