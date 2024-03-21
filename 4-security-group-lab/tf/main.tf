provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "backend_server" {
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.micro"
  key_name = "example"
  
  vpc_security_group_ids = [aws_security_group.http_backend_security.id,
   aws_security_group.ssh_backend_security.id]
  
  
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello Everyone" > index.html
              nohup busybox httpd -f -p 3000 &
              EOF
  
  tags = {
      Name = "backend server"
  }
}

resource "aws_security_group" "http_backend_security" {
  name = "http backend security"
  ingress {
    from_port   = "?"
    to_port     = "?"
    protocol    = "tcp"
    cidr_blocks = ["?"]
  }
}