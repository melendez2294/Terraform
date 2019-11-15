Terraform Documentation
____________________

ec2.tf 
-------
The code that is located inside of the ec2.tf script is used to automate the intital setup process for cloud infrastructure. It accomplishes this by creating various 
AWS resources which include a bastion host, two webservers, two security groups, and a s3 bucket with a dynamodb table to keep track of the current state 
of the Terraform environment. These resources are created almost instantly in the AWS console when the user executes the script with "$ terraform apply" 
command. It might be a good idea to test the code before implementing it by utilizing the "$ terraform plan" command. This command must be preceded by 
the execution of the "$terraform init" command since it ensures that the Terraform environment was setup properly. To delete any infrastructure created by this 
script, use the "$ terraform destroy" command to clear out these resources in the AWS console. This script depends on the s3 bucket stored in the s3bucket.tf script
to operate correctly, and both Terraform files should be placed in their appropriate folders within the hierarchical structure of the Terraform environment. The top portion 
of the ec2.tf file links to the s3 bucket container by refering to it. 

In the ec2.tf script, the code sets up the AWS cloud infrastructure in the "us-west-2" region which is in Oregon. It then creates each resource that was specified in the Terraform code 
starting with the bastion host to receive internet traffic to our network and ending with the Elastic Load Balancer (ELB) to filter through it. The bastion host possesses a security group that enables 
the use of SSH Remote Login protocol on port 22 of the web server. Two more generic web servers are made to hold information as to keep them secure from outside threats. They both 
belong to a security group in which traffic is allowed on ports 80 and 443 for HTTP and HTTPS protocol respectively. For the ELB to function properly it requires the path to the 
specific Amazon Resource Name (ARN). In this case, an Amazon Certificate Manager (ACM) certificate. This ARN variable is filled out completely under the "ssl_certificate_id" field in the 
ELB resource which allows it to operate on HTTPS internet traffic. An ACM certificate had to be issued by the owner of the "thegroupseniordesign.tech" domain name to get it working. 

s3bucket.tf 
-----------
The code found here focuses on forming a shared container that keeps track of the current state of the Terraform environment. It stores the various metadata files 
associated with the environment inside the S3 section of the AWS account under the list of created buckets. This script is comprised of three interconnected segments 
or blocks that work together. The last two of these blocks are the s3 bucket and dynamodb table resources, while the first one appears to be a reference to the 
s3 bucket container. 

Example: Folder Hierarchy of the Terraform Environment on Mark's Ubuntu 18 VM
-------------------------------------------------------------------------------------
This filesystem structure might help setup, execute, change, and destory resources relating to my Terraform code. 

	          Terraform 
                                 / | \
                               /   |   \
                             /     |     \
                           /       |       \ 
                      EC2/    ?/       ?/
                         |
                EC2.tf & s3/
                         | 
                    main.tf 






