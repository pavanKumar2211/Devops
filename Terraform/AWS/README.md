The code contains module for below AWS component
1. VPC             - VPC ,Subnets (Public, Private), IGW, Route Table, Routes, NAT Gateway
2. Security Groups - For EC2,EKS, RDS, MSK, ALB 
3. EC2             - Bastion host
4. EC2             - Solar Servers
5. RDS             - mysql
6. RDS             - Read Replica for mysql
7. ALB             - Application Load Balancerr
8. MSK             - Kafka cluster

AWS VPC module:
- version - "2.54.0"
- Module link : https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.54.0
- Module code on Git hub :https://github.com/terraform-aws-modules/terraform-aws-vpc


AWS EC2 Instance module
- version - 
- Module link : https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/2.15.0
- Module code on Git hub : https://github.com/terraform-aws-modules/terraform-aws-ec2-instance

Aws Security Groups modules :
- version -  "3.16.0"
- Module link : https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/3.16.0
- Module code on Git hub :  github.com/terraform-aws-modules/terraform-aws-security-group

AWS EKS module :
- version - "12.2.0"
- Module link : https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/12.2.0
- Module code on Git hub : https://github.com/terraform-aws-modules/terraform-aws-eks

AWS RDS module :
- version = "2.18.0"
- Module link : https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/2.18.0
- Module code on Git hub : https://github.com/terraform-aws-modules/terraform-aws-rds

AWS ALB module :
- version = "5.9.0"
- Module link : https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/5.9.0
- Module code on Git hub : https://github.com/terraform-aws-modules/terraform-aws-alb


Terraform state backend:
  •	Create an S3 Backet brefore executing code and it will store the state for terraform execution.

Note for eks cluster
  •	If you are executing the terraform code from windows machine uncomment below two variables from eks module.
      The module has a default configuration for Unix-like systems. In order to run the provisioner on Windows systems you must set the interpreter to a valid value.
      wait_for_cluster_interpreter = ["c:\\Git\\bin\\sh.exe", "-c"]
      wait_for_cluster_cmd         = "until curl -sk $ENDPOINT >/dev/null; do sleep 4; done"

  •	Make sure one of the Nat Gateways is created otherwise instances will not get attach to the node group.

Note for RDS:
  •	Provide Password for RDS

Note for ALB:
  •	Provide Certificate for ALB

Note for VPC module:
  •	This module supports three scenarios for creating NAT gateways. Each will be explained in further detail in the corresponding sections.
   One NAT Gateway per subnet (default behavior)
   •	enable_nat_gateway = true 
   •	single_nat_gateway = false
   •	one_nat_gateway_per_az = false
   Single NAT Gateway
   •	enable_nat_gateway = true
   •	single_nat_gateway = true
   •	one_nat_gateway_per_az = false
   One NAT Gateway per availability zone
   •	enable_nat_gateway = true
   •	single_nat_gateway = false
   •	one_nat_gateway_per_az = true
 If both single_nat_gateway and one_nat_gateway_per_az are set to true, then single_nat_gateway takes precedence.
