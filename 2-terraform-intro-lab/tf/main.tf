provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "backend_api" {
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.micro"
  

  tags = {
    Name = "Flask Api"
  }
}

output "display_ami_id" {
  value = aws_instance.backend_api.ami
}

