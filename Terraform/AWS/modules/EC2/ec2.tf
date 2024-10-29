############################EC2-Instance##################################

#EC2 module-To create bastion host
locals {
  user_data = <<EOF
#! /bin/bash
apt install zip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/aws-iam-authenticator
curl -o aws-iam-authenticator.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/aws-iam-authenticator.sha256
openssl sha1 -sha256 aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
EOF
}

resource "aws_eip" "this" {
  vpc      = true
  instance = "${module.ec2-bastion.id[0]}"
  tags = {
    "Name" = "${var.env}-bastion"
  }
}

module "ec2-bastion" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "2.15.0"
  name                        = "${var.env}-bastion-host"
  ami                         = var.bastion_ami
  instance_type               = var.bastion_instance_type
  tenancy                     = var.bastion_tenancy
  subnet_ids                  = var.subnet_ids
  key_name                    = var.bastion_key_name
  monitoring                  = var.bastion_instance_monitoring
  ebs_optimized               = var.bastion_instance_ebs_optimized
  #ebs_block_device = 
  #user_data                  = "${file("script.sh")}"
  user_data_base64            = base64encode(local.user_data)
  associate_public_ip_address = true
  #private_ip                  = var.bastion_private_ip
  tags = {
    AutoDigiBackup = "yes"
    AutoDigiBackupRetentionDays = "1"
    AutoDigiBackupSchedule = "*"
    name         = "${var.env}-bastion-host"
    environment  = var.env
    "created by" = "terraform"
    "created on" = "${var.created_on}"
  }
}
