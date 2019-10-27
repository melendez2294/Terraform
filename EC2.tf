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



