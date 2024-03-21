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
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_backend_security" {
    name = "ssh security"
    
    ingress {
        cidr_blocks = [
          "0.0.0.0/0"
        ]
    from_port = 22
        to_port = 22
        protocol = "tcp"
      }
    
      egress {
       from_port = 0
       to_port = 0
       protocol = "-1"
       cidr_blocks = ["0.0.0.0/0"]
     }
}

output "connection_instructions" {
  value = "ssh with the following: ssh -i ${aws_instance.backend_server.key_name}.pem ubuntu@${aws_instance.backend_server.public_dns}" 
}
