terraform {
    backend  "s3" {
    region         = "us-west-2"
    bucket         = "cit480-thegroup"
    key            = "ec2/terraform.tfstate" 
    dynamodb_table = "tf-state-lock"
    }
} 

provider "aws" {
      region = "us-west-2"
}

resource "aws_instance" "bastion" {
      ami = "ami-06d51e91cea0dac8d"
      instance_type = "t2.micro"
      key_name = "Project1"
      security_groups = ["${aws_security_group.bastion-sg.name}"]
      root_block_device { 
      		delete_on_termination = true 
      }
      tags = {
		Name = "bastionhost"
      }
}

resource "aws_security_group" "bastion-sg" {
	name = "bastion-securitygroup"
	description = "allow port 22"
	ingress { 
   	   from_port = 22 
	   to_port = 22 
  	   protocol = "tcp" 
 	   cidr_blocks = ["0.0.0.0/0"]
	}

	egress { 
           from_port = 0
   	   to_port = 0 
  	   protocol = "-1"
	   cidr_blocks = ["0.0.0.0/0"]
 	}
}

resource "aws_instance" "web-server-1" {
      ami = "ami-06d51e91cea0dac8d"
      instance_type = "t2.micro"
      key_name = "Project1"
      security_groups = ["${aws_security_group.aws-sg.name}"]
      root_block_device { 
      		delete_on_termination = true 
      }
      tags = {
		Name = "webserver1"
      }
}

resource "aws_instance" "web-server-2" {
      ami = "ami-06d51e91cea0dac8d"
      instance_type = "t2.micro"
      key_name = "Project1"
      security_groups = ["${aws_security_group.aws-sg.name}"]
      root_block_device { 
      		delete_on_termination = true 
      }
      tags = {
		Name = "webserver2"
      }
}

resource "aws_security_group" "aws-sg" {
	name = "aws-securitygroup"
	description = "allow ports 80 and 443"
	ingress { 
   	   from_port = 80 
	   to_port = 80 
  	   protocol = "tcp" 
 	   cidr_blocks = ["0.0.0.0/0"]
	}
	egress { 
           from_port = 0
   	   to_port = 0 
  	   protocol = "-1"
	   cidr_blocks = ["0.0.0.0/0"]
 	}

	ingress { 
   	   from_port = 443 
	   to_port = 443 
  	   protocol = "tcp" 
 	   cidr_blocks = ["0.0.0.0/0"]
	}
	egress { 
           from_port = 0
   	   to_port = 0 
  	   protocol = "-1"
	   cidr_blocks = ["0.0.0.0/0"]
 	}
}

