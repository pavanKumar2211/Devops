############################  Security Groups  ##############################

#Security group - with allow ssh to bastion host from 0.0.0.0/0
module "sg-bastion-ssh" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.16.0"
  description = "security group for bastion host to allow ssh Specific IPs"
  name        = "${var.env}-bastion-sg"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh from 103.81.79.10/32"
      cidr_blocks = "103.81.79.10/32"
  },
   {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh from 103.81.79.15/32"
      cidr_blocks = "103.81.79.15/32"
  },
   {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh from 103.81.79.35/32"
      cidr_blocks = "103.81.79.35/32"
  },
   {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh from 103.81.78.10/32"
      cidr_blocks = "103.81.78.10/32"
  },
   {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh from 103.81.78.15/32"
      cidr_blocks = "103.81.78.15/32"
  },
  {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh from 15.206.241.70/32"
      cidr_blocks = "15.206.241.70/32"
  },
  {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh from R1 Bastion Host"
      cidr_blocks = "3.109.165.5/32"
  }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "ssh from 0.0.0.0/0"
      cidr_blocks = "0.0.0.0/0"
  }]
  tags = {
    name         = "${var.env}-bastion-sg"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
}

#Security group - with allow ssh to bastion host from 0.0.0.0/0
module "sg-all-from-bastion-ssh" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.16.0"
  description = "security group for bastion host to allow ssh from anywhere"
  name        = "${var.env}-all-from-bastion-sg"
  vpc_id      = module.vpc.vpc_id
  ingress_with_source_security_group_id = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "ssh from 0.0.0.0/0"
      source_security_group_id = "${module.sg-bastion-ssh.this_security_group_id}"
  }]
  tags = {
    name         = "${var.env}-bastion-sg"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
} 



#Security group - with allow mysql port access from bastion host and EKS cluster and worker nodes to RDS instance
module "sg-mysql" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.16.0"
  name    = "${var.env}-mysql-sg"
  vpc_id  = module.vpc.vpc_id
  ingress_with_source_security_group_id = [{
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "mysql port ingress from bastion"
      source_security_group_id = "${module.sg-bastion-ssh.this_security_group_id}" 
    },
    /*{
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "mysql port ingress from eks cluster"
      source_security_group_id = "${module.eks.cluster_security_group_id}" 
    },*/
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "mysql port ingress from eks worker"
      source_security_group_id = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id }]
  tags = {
    name         = "${var.env}-mysql-sg"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
} 

module "sg-mysql-cdp" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.16.0"
  name    = "${var.env}-cdp-to-security-rds-sg"
  vpc_id  = module.vpc.vpc_id
  ingress_with_cidr_blocks = [{
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "from CDP AWS account"
      cidr_blocks = "10.100.0.0/16"
    },    
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "from CDP AWS account"
      cidr_blocks = "13.235.33.101/32"
    }
  ]
  tags = {
    name         = "${var.env}-cdp-to-security-rds-sg"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
} 

#Security Group - for alb 
module "sg-alb" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.16.0"
  description = "security group with allow http and https port from 0.0.0.0/0 and ::/0"
  name        = "${var.env}-alb-sg"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [    
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "https port for ipv4"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  ingress_with_ipv6_cidr_blocks = [   
    {
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      description      = "https port for ipv6"
      ipv6_cidr_blocks = "::/0"
  }]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "ssh from 0.0.0.0/0"
      cidr_blocks = "0.0.0.0/0"
  }]

  tags = {
    name         = "${var.env}-alb-sg"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
}


#Security Group - for secure alb 
module "sg-secure-alb" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.16.0"
  description = "security group with allow http and https port from specific IPs"
  name        = "${var.env}-secure-alb-sg"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [    
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "HTTPS from 13.126.229.175/32"
        cidr_blocks = "13.126.229.175/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "HTTPS from 35.154.3.229/32"
        cidr_blocks = "35.154.3.229/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Proxy-3"
        cidr_blocks = "13.234.100.123/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Proxy-2"
        cidr_blocks = "65.1.152.13/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Proxy-1"
        cidr_blocks = "13.233.23.236/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "NAT GATEWAY of DEV for pentaho"
        cidr_blocks = "15.207.97.177/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "NAT GATEWAY of DEV for pentaho"
        cidr_blocks = "15.206.241.70/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "From perf team windows server"
        cidr_blocks = "3.108.100.244/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Vasanth IP"
        cidr_blocks = "49.206.193.189/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "HYD TATA"
        cidr_blocks = "14.143.173.83/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Vasants IP"
        cidr_blocks = "14.143.173.80/29"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Vasanths IP"
        cidr_blocks = "14.143.173.218/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "FNP HO IP VPN - Akhtar"
        cidr_blocks = "103.158.95.121/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Delhi Office IP-1"
        cidr_blocks = "182.76.246.204/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Delhi Office IP-2"
        cidr_blocks = "110.232.252.102/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "HO VPN fnp by AKhtar"
        cidr_blocks = "45.122.46.138/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "CC-Proxy-1"
        cidr_blocks = "3.7.180.172/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Delhi Office IP"
        cidr_blocks = "136.232.146.193/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "R1 Infra"
        cidr_blocks = "172.19.0.0/16"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "NAT gateway of production VPC for pentaho to reach here"
        cidr_blocks = "3.109.127.232/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Delhi Office IP"
        cidr_blocks = "45.122.46.137/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "CC Gurgav Office IP"
        cidr_blocks = "14.99.240.18/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "CC-Proxy-2"
        cidr_blocks = "15.206.14.176/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "Kali Linux IP"
        cidr_blocks = "13.127.255.9/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "cc-gurgav-office-IP"
        cidr_blocks = "125.16.116.114/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "CC-Proxy-Backup"
        cidr_blocks = "13.232.68.133/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "R1 NAT GW"
        cidr_blocks = "13.126.131.176/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        description = "HO IP"
        cidr_blocks = "136.232.146.194/32"
    }
  ]
  
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "ssh from 0.0.0.0/0"
      cidr_blocks = "0.0.0.0/0"
  }]

  tags = {
    name         = "${var.env}-secure-alb-sg"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
}


#Security Group - sg-all-from-alb
module "sg-all-from-alb" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.16.0"
  description = "security group with allow http and https port from 0.0.0.0/0 and ::/0"
  name        = "${var.env}-all-from-alb-sg"
  vpc_id      = module.vpc.vpc_id
  ingress_with_source_security_group_id = [    
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "https port for ipv4"
      source_security_group_id = "${module.sg-alb.this_security_group_id}"
    }
  ]
 
  tags = {
    name         = "${var.env}-from-alb-sg"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
}

##############EFS sg
module "sg-efs" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.16.0"
  description = "security group with allow http and https port from 0.0.0.0/0 and ::/0"
  name        = "${var.env}-efs-sg"
  vpc_id      = module.vpc.vpc_id
   
  ingress_with_source_security_group_id = [{
      from_port       = 2049
      to_port         = 2049
      protocol    = "tcp"
      description = "from Bastion"
      source_security_group_id = "${module.sg-all-from-bastion-ssh.this_security_group_id}"
    },
    {
      from_port       = 2049
      to_port         = 2049
      protocol    = "tcp"
      description = "from EKS cluster"
      source_security_group_id = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id
      
    }]
  
  tags = {
    name         = "${var.env}-alb-sg"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
}

#Security Group for lambda fuction
module "LambdaFunction_sg" {
  source             = "terraform-aws-modules/security-group/aws"
  version            = "3.18.0"
  name               = "${var.env}_LambdaFunction_sg"
  description        = "Security group for LambdaFunction"
  vpc_id             = module.vpc.vpc_id
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
  tags = {
    environment     = "${var.env}_lambda_sg"
    
  }
}

#Security Group for lambda fuction
module "shopping-cart-lambda-function-sg" {
  source             = "terraform-aws-modules/security-group/aws"
  version            = "3.18.0"
  name               = "${var.env}-shopping-cart-LambdaFunction-sg"
  description        = "Security group for Shopping Cart LambdaFunction"
  vpc_id             = module.vpc.vpc_id
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
  tags = {
    environment     = "${var.env}_lambda_sg"
    
  }
}

# Security group for freshping IP's 443
module "freshping-ip-sg-443" {
  source             = "terraform-aws-modules/security-group/aws"
  version            = "3.18.0"
  name               = "freshping_ips_443"
  description        = "freshping_ips_443"
  vpc_id             = module.vpc.vpc_id

  ingress_with_cidr_blocks = [    
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "52.60.140.174/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "13.232.175.73/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "34.246.131.0/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "18.228.60.182/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "50.17.185.102/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "18.130.156.195/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "13.251.205.206/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "52.42.49.200/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "18.179.133.14/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "35.173.69.86/32"
    },
    {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "13.55.57.184/32"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "ssh from 0.0.0.0/0"
      cidr_blocks = "0.0.0.0/0"
  }]
}

# Security group for freshping IP's 80
module "freshping-ip-sg-80" {
  source             = "terraform-aws-modules/security-group/aws"
  version            = "3.18.0"
  name               = "freshping_ips_80"
  description        = "freshping_ips_80"
  vpc_id             = module.vpc.vpc_id

  ingress_with_cidr_blocks = [    
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "52.60.140.174/32"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "13.232.175.73/32"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "34.246.131.0/32"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "18.228.60.182/32"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "50.17.185.102/32"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "18.130.156.195/32"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "13.251.205.206/32"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "52.42.49.200/32"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "18.179.133.14/32"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "35.173.69.86/32"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "13.55.57.184/32"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "ssh from 0.0.0.0/0"
      cidr_blocks = "0.0.0.0/0"
  }]
}


###################### eks sg
/*
module "sg-eks-cluster" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.16.0"
  description = "Cluster communication with worker nodes"
  name        = "${var.env}-eks-cluster-sg"
  vpc_id      = module.vpc.vpc_id

  egress_with_source_security_group_id = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      source_security_group_id = "${module.sg-eks-cluster.this_security_group_id}"
  }]

  ingress_with_source_security_group_id = [{
      from_port       = 443
      to_port         = 443
      protocol    = "tcp"
      description = "Allow workstation to communicate with the cluster API Server"
      source_security_group_id = "${module.sg-eks-cluster.this_security_group_id}"
    },
    ]

  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "-1"
      cidr_blocks =  "0.0.0.0/0"
  }]

  tags = {
    name         = "${var.env}-eks-cluster-sg"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
}
*/