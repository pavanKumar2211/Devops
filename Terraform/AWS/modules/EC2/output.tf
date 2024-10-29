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


