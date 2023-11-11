terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_access" {
  name        = "web access"
  description = "Allow inbound traffic on ports 22 and 80"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example_instance" {
  ami             = "ami-0c55b159cbfafe1f0"  # Specify your desired AMI ID
  instance_type   = "t2.micro"
  security_group  =  ["${aws_security_group.web_access.name}"]

  tags = {
    Name = "example-instance"
  }
}

