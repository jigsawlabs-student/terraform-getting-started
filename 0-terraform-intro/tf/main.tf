provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "backend_server" {
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.micro"
  
  tags = {
      Name = "some backend server"
  }
}

output "ec2_global_dns" {
  value = aws_instance.backend_server.public_dns 
}