#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "eks-node-group-role" {
  name =  "${var.env}-eks-node"

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

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "${var.env}-eks-node"
  node_role_arn   = aws_iam_role.eks-node-group-role.arn
  subnet_ids      = [module.vpc.private_subnets[0]]
  #subnet_ids      = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
  instance_types  = [var.node_group_instance_type]
  disk_size       = var.node_group_disk_size
  /* # release_version = var.node_group_ami_release_version */ 
  scaling_config {
    desired_size = var.node_group_desired_capacity
    max_size     = var.node_group_max_capacity
    min_size     = var.node_group_min_capacity
  }
  
  // Dont accept ami ID
  //ami_type                  = var.node_group_2_ami_type
   remote_access {
    ec2_ssh_key               = var.bastion_key_name
    source_security_group_ids = ["${module.sg-bastion-ssh.this_security_group_id}",aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-node-AmazonEC2ContainerRegistryReadOnly,
  ]

   labels = {
        environment = var.env
        purpose = "${var.env}"
      }
   tags = {
        Name      = "${var.env}-eks-node"
        "kubernetes.io/cluster/eks" = "owned"
        environment  = var.env
      }
}
