data "aws_vpc" "my_vpc" {
  id = var.vpc_id  
}

data "aws_subnet" "public_subnet_01" {
  id = var.public_subnet_01
}

data "aws_subnet" "public_subnet_02" {
  id = var.public_subnet_02
}

resource "aws_route_table" "rt_private" {
    vpc_id = data.aws_vpc.my_vpc.id
    tags = {
      Name = "jp-pc-itps-rt-private"
    }
}

resource "aws_route_table_association" "rt_private_ass01" {
  subnet_id = aws_subnet.private_subnet_01.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_private_ass02" {
  subnet_id = aws_subnet.private_subnet_02.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_subnet" "private_subnet_01" {
  vpc_id = data.aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidrs[0]
  map_public_ip_on_launch = "false"
  availability_zone = var.availability_zone[0]
  tags = {
    Name = "jp-pc-itps-private-subnet-01"
  }
}

resource "aws_subnet" "private_subnet_02" {
  vpc_id = data.aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidrs[1]
  map_public_ip_on_launch = "false"
  availability_zone = var.availability_zone[1]
  tags = {
    Name = "jp-pc-itps-private-subnet-02"
  }
}