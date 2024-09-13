#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "horizontal-eks-node-group-role-new" {
  name =  "${var.env}-eks-node-horizontal-new"

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

resource "aws_iam_role_policy_attachment" "horizontal-eks-node-AmazonEKSWorkerNodePolicy-new" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.horizontal-eks-node-group-role-new.name
}

resource "aws_iam_role_policy_attachment" "horizontal-eks-node-AmazonEKS_CNI_Policy-new" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.horizontal-eks-node-group-role-new.name
}

resource "aws_iam_role_policy_attachment" "horizontal-eks-node-AmazonEC2ContainerRegistryReadOnly-new" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.horizontal-eks-node-group-role-new.name
}

resource "aws_eks_node_group" "eks-node-group-horizontal-new" {
  cluster_name    = aws_eks_cluster.eks-cluster-new.name
  node_group_name = "${var.env}-eks-node-horizontal"
  node_role_arn   = aws_iam_role.horizontal-eks-node-group-role-new.arn
  subnet_ids      = [module.vpc.private_subnets[0]]
  #subnet_ids      = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
  instance_types  = [var.node_group_horizontal_instance_type_new]
  disk_size       = var.node_group_horizontal_disk_size_new
  # release_version = var.node_group_ami_release_version_new
  scaling_config {
    desired_size = var.node_group_horizontal_desired_capacity_new
    max_size     = var.node_group_horizontal_max_capacity_new
    min_size     = var.node_group_horizontal_min_capacity_new
  }
  
  // Dont accept ami ID
  //ami_type                  = var.node_group_2_ami_type
   remote_access {
    ec2_ssh_key               = var.bastion_key_name
    source_security_group_ids = ["${module.sg-bastion-ssh.this_security_group_id}",aws_eks_cluster.eks-cluster-new.vpc_config[0].cluster_security_group_id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.horizontal-eks-node-AmazonEKSWorkerNodePolicy-new,
    aws_iam_role_policy_attachment.horizontal-eks-node-AmazonEKS_CNI_Policy-new,
    aws_iam_role_policy_attachment.horizontal-eks-node-AmazonEC2ContainerRegistryReadOnly-new,
  ]

   labels = {
        environment = var.env
        purpose = "${var.env}-horizontal"
      }
   tags = {
        Name      = "${var.env}-eks-node-horizontal"
        "kubernetes.io/cluster/eks" = "owned"
        environment  = var.env
      }
}
