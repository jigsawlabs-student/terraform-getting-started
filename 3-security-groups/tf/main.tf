provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "simple_web_app" {
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.micro"
  key_name = "example"
  
  
  tags = {
      Name = "simple web app"
  }


  user_data = <<-EOF
              #!/bin/bash
              mkdir -p /var/www/html
              cd /var/www/html
              echo "Hello, World" > /var/www/html/index.html
              nohup busybox httpd -f -p 80 &
              EOF
}

resource "aws_security_group" "web_app_security" {
  name = "web_app_security4"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

