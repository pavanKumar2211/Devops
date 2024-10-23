#### environment Specific Variable####


variable "create_secure_alb" {
  description = "Decide if additional alb to be created or not TRUE=Create FALE=Dont create"
  type        = bool
}










variable "env" {
  description = "The environment name"
  type        = string

}

####created_on
variable "created_on" {
  description = "creation date"
  type        = string

}
#### VPC variables ####
##### varibles for security groups ####


#set skip_final_snapshot variable to flase in production
