# Required for the s3 bucket
terraform {
    backend  "s3" {
    region         = "us-west-2"
    bucket         = "cit480-thegroup"
    key            = "ec2/terraform.tfstate" 
    dynamodb_table = "tf-state-lock"
    }
} 

# AWS services and infrastructure 
provider "aws" {
      region = "us-west-2"
}

# Bastion 
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

# Bastion security group 
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

# Web server 1 
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

# Web server 2
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

# Web server security group 
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

# Block below requires an ACM certificate and ARN from the domain name owner to establish SSL connection - Garrett 
# ACM certificate required for the load balancer 
resource "aws_acm_certificate" "cert" {
  domain_name       = "thegroupseniordesign.tech"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create a new load balancer
resource "aws_elb" "elb" {
  name               = "terraform-elb"
  availability_zones = ["us-west-2a"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # This block requires an ACM certificate and ARN from the domain name owner to establish SSL connection - Garrett
  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${ arn:aws:acm:us-west-2:327250713413:certificate/c058d0e9-b749-4406-989a-c20f1d538a57}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = ["${aws_instance.bastion.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "terraform-elb"
  }
}

