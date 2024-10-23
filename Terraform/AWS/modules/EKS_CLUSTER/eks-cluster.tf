#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_iam_role" "eks-cluster" {
  name = "${var.eks_cluster_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-cluster.name
}

# EKS Control Plane security group
resource "aws_security_group_rule" "alb-cluster-security-group-rule" {
  from_port                = 30000
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.eks-cluster.vpc_config.0.cluster_security_group_id
  source_security_group_id = "${module.sg-alb.this_security_group_id}"
  to_port                  = 32767
  type                     = "ingress"
  depends_on = [aws_eks_cluster.eks-cluster]
}

resource "aws_security_group_rule" "secure-alb-cluster-security-group-rule" {
  from_port                = 30000
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.eks-cluster.vpc_config.0.cluster_security_group_id
  source_security_group_id = "${module.sg-secure-alb.this_security_group_id}"
  to_port                  = 32767
  type                     = "ingress"
  depends_on = [aws_eks_cluster.eks-cluster]
}

resource "aws_security_group_rule" "alb-cluster-security-group-rule-for-bastion" {
  from_port   = 0
  protocol                 = "-1"
  security_group_id       = aws_eks_cluster.eks-cluster.vpc_config.0.cluster_security_group_id
  source_security_group_id = "${module.sg-alb.this_security_group_id}"
  to_port                  = 0
  type                     = "ingress"
  depends_on = [aws_eks_cluster.eks-cluster]
}

resource "aws_security_group_rule" "alb-cluster-security-group-rule-for-access-by-bastion" {
  from_port   = 0
  protocol                 = "-1"
  security_group_id       = aws_eks_cluster.eks-cluster.vpc_config.0.cluster_security_group_id
  source_security_group_id = "${module.sg-bastion-ssh.this_security_group_id}"
  to_port                  = 0
  type                     = "ingress"
  depends_on = [aws_eks_cluster.eks-cluster]
}

resource "aws_security_group_rule" "alb-cluster-security-group-rule-for-kafka" {
  from_port   = 0
  protocol                 = "-1"
  security_group_id        = aws_eks_cluster.eks-cluster.vpc_config.0.cluster_security_group_id
  cidr_blocks              = [var.vpc_cidr]
  to_port                  = 0
  type                     = "ingress"
  depends_on = [aws_eks_cluster.eks-cluster]
}


resource "aws_eks_cluster" "eks-cluster" {
  name     = "${var.eks_cluster_name}"
  role_arn = aws_iam_role.eks-cluster.arn

  version = var.eks_cluster_version
  
  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    endpoint_private_access = true  
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKS_CNI_Policy,
  ]
  tags = {
    Name         = "${var.eks_cluster_name}"
    environment  = var.environment
    "Created by" = "terraform"
    "created on" = "${var.creation_date}"
  }
}
