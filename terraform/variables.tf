variable "availability_zones" {
  type = list(any)
  description = "AZ's"
  default = [ "eu-west-1a","eu-west-1b","eu-west-1c"]
}

variable "product" {
  type        = string
  default     = "offerzen"
  description = "Top Level Resources Identification [string]"
}

variable cw_sns_topic {
  description = "CloudWatch SNS Topic for notifications"
  type        = string     # Default value, can be overridden in env-specific files
}

variable "env" {
  description = "Environment [string]"
}

variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS Region [string]"
}

variable "domain_name" {
  description = "Domain Name used with Route53 [string]"
}

variable "stack" {
  description = "Stack Name for the set of resources [string]"
}

### VPC ####

variable "vpc_cidr_block" {
    type = string
    description = "vpc CIDR block"
}

variable "public_subnet_cidr_blocks" {
  type = list(any)
  description = "public subnest cidr blocks"
}

variable "private_subnet_cidr_blocks" {
  type = list(any)
  description = "public subnest cidr blocks"
}

variable "subnet_pb" {
  
}

variable "subnet_prt" {
  
}
variable email_endpoint{
  description = "Email endpoint for SES"
  type = string
}

variable "rds_instance_class" {
  description = "Instance class for the RDS set of resources [string]"
}

variable "rds_engine_version" {
  description = "Engine version for the RDS set of resources [string]"
}

variable "rds_engine" {
  description = "Engine for the RDS set of resources [string]"
}

variable "rds_postgres_rules" {
  description = "rds postgress rules"
  type = list
}

variable "ecs_task_pub_sg_rules" {
  description = "ECS Task Security Group Rules in public subnet"
  type = list
}

variable "http_alb_rules" {
  description = " ALB Security Group Rules"
  type = list
}

#variable "ecs_task_prt_sg_rules" {
#  description = "ECS Task Security Group Rules in private subnet"
#  type = list
#}

variable "HostedZoneId" {
  description = "Route53 Hosted Zone ID"
  type = string
}