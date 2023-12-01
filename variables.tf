variable "inbound_port_ec2" {
    type = list(any)
    default = [22,80]
    description = "Inbound port allowed to access EC2"
}

variable "db_name" {
    type = string
    default = "wordpressdatabase"
}

variable "instance_type" {
  type = string
  description = "EC2 types allowed: t2.micro, t2.nano"
  validation {
    condition = contains(["t2.micro","t2.nano"],var.instance_type)
    error_message = "Only t2.micro | t2.nano allowed"
  }
}

variable "availability_zone" {
    type = list(string)
    default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "vpc_id" {
    type = string   
    default = "vpc-03ca74813b3d4f476"
}
variable "public_subnet_01" {
  type    = string
  default = "subnet-024bb1296afb9cd1f"
}

variable "public_subnet_02" {
  type = string
  default = "subnet-01cfc777d89969b46"
}

variable "subnet_cidrs" {
    type = list(string)
    description = "CIDRS for private subnets"
    default = ["10.72.137.64/27","10.72.137.96/27" ]
}

variable "target_app_port" {
    type = string
    default = "80"
}

variable "private_key" {
    description = "Private key pair"
    type = string
    default = "wordpress-project.pem"
}

variable "mount_directory" {
    type = string
    default = "/var/www/html"
} 

variable "wp_credential" {
    type = string   
    default = "wordpress-db"
}