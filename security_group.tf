resource "aws_security_group" "front_end_sg" {
    name = "Front-End-SG"
    description = "Allow traffic on port 22 and 80"
    vpc_id = data.aws_vpc.my_vpc.id
    
    dynamic "ingress" {
        for_each = var.inbound_port_ec2
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "rds_sg" {
    name = "Database-SG"
    description = "Allow traffic on port 3306"
    vpc_id = data.aws_vpc.my_vpc.id
    
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.front_end_sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }  
}

resource "aws_security_group""efs_sg" {
    name = "EFS-SG"
    description = "Allow traffic EFS"
    vpc_id = data.aws_vpc.my_vpc.id
    
    ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_groups = [aws_security_group.front_end_sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }     
}