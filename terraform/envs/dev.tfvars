product     = "http"
env         = "dev"
region      = "eu-west-1"
domain_name = "poc-http.labs.com"  # Replace with your actual domain name
stack       = "http"
HostedZoneId = "XDSRWEANSG"  # Example Hosted Zone ID, replace with your actual ID

# VPC
vpc_cidr_block = "10.100.0.0/24"
public_subnet_cidr_blocks = [ "10.100.0.0/27", "10.100.0.32/27" ]
private_subnet_cidr_blocks= [ "10.100.0.64/27", "10.100.0.96/27" ]
email_endpoint = "gansieprince@gmail.com" # Set this variable to your email endpoint
cw_sns_topic = "rds-sqs-notifications-topic"

subnet_pb = "public"
subnet_prt = "private"
rds_instance_class = "db.t3.medium"
rds_engine_version = "16.6"
rds_engine = "aurora-postgresql"

rds_postgres_rules = [
  { type = "ingress", protocol = "tcp", from_port = 5432, to_port = 5432, cidr_blocks = ["10.100.0.0/27"], description = "instances in public_subnet_1" },
  { type = "ingress", protocol = "tcp", from_port = 5432, to_port = 5432, cidr_blocks = ["10.100.0.32/27"], description = "instances in public_subnet_2" },
  { type = "egress", protocol = "all", from_port = 0, to_port = 0, cidr_blocks = ["0.0.0.0/0"], description = "egress all" }
]

http_alb_rules = [
  { type = "ingress", protocol = "tcp", from_port = 8080, to_port = 8080, cidr_blocks = ["0.0.0.0/0"], description = "HTTP from Internet" },
  { type = "egress", protocol = "all", from_port = 0, to_port = 0, cidr_blocks = ["0.0.0.0/0"], description = "egress all" }
 ]

 ecs_task_pub_sg_rules =[
  { type = "ingress", protocol = "tcp", from_port = 8080, to_port = 8080, cidr_blocks = ["10.100.0.0/27"], description = "Instances in public_subnet_1" },
  { type = "ingress", protocol = "tcp", from_port = 8080, to_port = 8080, cidr_blocks = ["10.100.0.32/27"], description = "Instances in public_subnet_2" },
  { type = "egress", protocol = "all", from_port = 0, to_port = 0, cidr_blocks = ["0.0.0.0/0"], description = "egress all" }
 ]

 #ecs_task_prt_sg_rules =[
 # { type = "egress", protocol = "all", from_port = 0, to_port = 0, cidr_blocks = ["0.0.0.0/0"], description = "egress all" }
 #]
