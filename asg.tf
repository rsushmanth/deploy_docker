# Launch Configuration
resource "aws_launch_configuration" "app" {
  name                 = "app-launch-configuration"
  image_id             = "ami-00beae93a2d981137"
  instance_type        = "t2.micro"
  security_groups      = [aws_security_group.web_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  key_name             = aws_key_pair.my_key.key_name
  user_data            = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo dnf -y install docker
                sudo systemctl start docker
                sudo docker pull yeasy/simple-web
                sudo docker run -d -p 80:80 yeasy/simple-web
                EOF

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_key_pair" "my_key" {
  key_name   = "my_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# resource "aws_instance" "web" {
#  ami             = "ami-00beae93a2d981137" # Amazon Linux 2 AMI
#  instance_type   = "t2.micro"
#  key_name        = aws_key_pair.my_key.key_name
#  security_groups = [aws_security_group.web_sg.name]

#  tags = {
#    Name = "docker-web-app"
#  }

#  user_data = <<-EOF
#                  #!/bin/bash
#                  sudo yum update -y
#                  sudo systemctl start docker
#                  sudo systemctl start docker
#                  sudo docker pull yeasy/simple-web
#                  sudo docker run -d -p 80:80 yeasy/simple-web
#                  EOF
#}

# Auto Scaling Group
resource "aws_autoscaling_group" "app" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  launch_configuration = aws_launch_configuration.app.id
  vpc_zone_identifier  = [aws_subnet.public.id]

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
}  