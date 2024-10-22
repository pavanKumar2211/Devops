output "vpc_details" {
  description = "The created subnet resources"
  value       = module.vpc-network.network_name
}

