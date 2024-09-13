output "instance_name" {
    value   =  google_sql_database_instance.instance
} 

output "google_service_networking_connection" {
    value   =  google_service_networking_connection.private_vpc_connection
} 
