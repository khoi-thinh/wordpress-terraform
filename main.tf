data "aws_ami" "amazon_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "server01" {
  ami = data.aws_ami.amazon_2.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = data.aws_subnet.public_subnet_01.id
  vpc_security_group_ids = [aws_security_group.front_end_sg.id]
  key_name = aws_key_pair.ec2_key_pair.id
  tags = {
    Name = "Wordpress01"
    Env = "Prod"
  }
  depends_on = [
  aws_db_instance.rds_master,
  ]
}

resource "aws_instance" "server02" {
  ami = data.aws_ami.amazon_2.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = data.aws_subnet.public_subnet_02.id
  vpc_security_group_ids = [aws_security_group.front_end_sg.id]
  key_name = aws_key_pair.ec2_key_pair.id
  tags = {
    Name = "Wordpress02"
    Env = "Prod"
  }
  depends_on = [
  aws_db_instance.rds_master,
  ]
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "rds subnet"
  subnet_ids = [aws_subnet.private_subnet_01.id, aws_subnet.private_subnet_02.id]
} 

data "aws_secretsmanager_secret" "wordpress_db" {
  name = var.wp_credential
}

data "aws_secretsmanager_secret_version" "secret_credentials" {
  secret_id = data.aws_secretsmanager_secret.wordpress_db.id  
}

resource "aws_db_instance" "rds_master" {
  identifier = "rds-master"
  allocated_storage = 10
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t3.micro"
  db_name = var.db_name
  username = jsondecode(data.aws_secretsmanager_secret_version.secret_credentials.secret_string)["wp_username"]
  password = jsondecode(data.aws_secretsmanager_secret_version.secret_credentials.secret_string)["wp_password"]
  backup_retention_period = 7
  multi_az = false
  availability_zone = var.availability_zone[0]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.id
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  storage_encrypted = true
  tags = {
    Name = "rds-master"
  }
}