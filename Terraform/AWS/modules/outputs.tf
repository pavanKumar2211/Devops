

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


####################################################################

#rds


####################################################################
#EKS


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

