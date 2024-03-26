provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "backend_server" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  key_name = "example"
              
  vpc_security_group_ids = [aws_security_group.http_backend_security.id]
  tags = {
      Name = "backend server"
  }

  user_data = <<-EOF
              #!/bin/bash
              mkdir -p /var/www/html
              echo "Hello Everyone" > /var/www/html/index.html
              cd /var/www/html
              nohup busybox httpd -f -p 80 &
              EOF
}

resource "aws_security_group" "http_and_ssh_security" {
  ingress {
    from_port   = ""
    to_port     = ""
    protocol    = "tcp"
    cidr_blocks = []
  }
}