provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "simple_web_app" {
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_app_security.id]

  tags = {
      Name = "simple web app"
  }


  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 80 &
              EOF
}

resource "aws_security_group" "web_app_security" {
  name = "web_app_security"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

