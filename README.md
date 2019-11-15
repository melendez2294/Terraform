# Terraform Infrastructure Project 1
## Task Description:  
  The general goal is to create a website hosted on AWS that only allows secure connection through SSL and hosts an interactable website.
## Deliverables:
  - Everything must be done through automation.  This is doen using Terraform and Ansible.
  - Terraform is to create the infrastructure, while ansible is to configure the servers once they have been created.
  - There shall be two servers hosting the website on private subnets while a load balancer (in our case, ELB) is there to split up the traffic between the both of them.
  - A bastion is to be created so there is no direct SSH to the webservers and the security aspects are delt with on the bastion as a middle man.
  - Within the bastion, there should be security measures to ensure that brute force attacks can not persist.
## Terraform Tasks:
  - **IAM**: Users, groups, policies for the groups, and user logins must be automatically created.  Keybase is used partially for the secure login credential creation.
  - **VPC**: The subnets, route tables, internet gatewats, and NAT instances should be created.
  - **Route53**: The routing table should be created with references to the SSL certificate to ensure it is validated and used for the ELB.
  - **EC2**: The webservers 1 and 2 should be created and configured later.
  - **Security Groups**: There should be security groups attached to each EC2 instance.
  - **ELB**: The load balancer should reference the EC2 instances to do any given load balancing system and also have a failover system in place.
## Ansible Tasks:
  - The one ansible task at hand is to install apache and copy over the webserver html and css files to those EC2 instances.
  - This must be done through the bastion set up to transfer it to the webservers as the middle-man.
  
## Serverless tasks:
  - Two lambda functions should be created to start and stop the EC2 instances at specific times through the cloud cronjobs.
