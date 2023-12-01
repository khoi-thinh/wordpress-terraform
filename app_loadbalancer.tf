# Application Load Balancer
resource "aws_lb" "app_lb" {
    name = "Wordpress-App-LB"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.front_end_sg.id]
    subnets = [data.aws_subnet.public_subnet_01.id, data.aws_subnet.public_subnet_02.id]
}

# Target group for Application Load Balancer
resource "aws_lb_target_group" "app_lb_tg" {
    name = "Target-Group-ALB"
    port = var.target_app_port
    protocol = "HTTP"
    vpc_id = data.aws_vpc.my_vpc.id
}

# Register target group with Application Load Balancer
resource "aws_lb_listener" "app_lb_listener" {
    load_balancer_arn = aws_lb.app_lb.arn
    port = var.target_app_port
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.app_lb_tg.arn
    }
}

# Register EC2s with target group
resource "aws_lb_target_group_attachment" "attachment_01" {
    target_group_arn = aws_lb_target_group.app_lb_tg.arn
    target_id = aws_instance.server01.id
    port = var.target_app_port
    depends_on = [aws_instance.server01]
}

resource "aws_lb_target_group_attachment" "attachment_02" {
    target_group_arn = aws_lb_target_group.app_lb_tg.arn
    target_id = aws_instance.server02.id
    port = var.target_app_port
    depends_on = [aws_instance.server02]
}
