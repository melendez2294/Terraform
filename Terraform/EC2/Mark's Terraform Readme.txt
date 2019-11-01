Terraform Documentation
_______________________

ec2.tf 
-------
The code that is located inside of the ec2.tf script is used to automate the intital setup process for cloud infrastructure. It accomplishes this by creating various 
AWS resources which include a bastion host, two webservers, two security groups, and a s3 bucket with a dynamodb table to keep track of the current state 
of the Terraform environment. These resources are created almost instantly in the AWS console when the user executes the script with "$ terraform apply" 
command. It might be a good idea to test the code before implementing it by utilizing the "$ terraform plan" command. This command must be preceded by 
the execution of the "$terraform init" command since it ensures that the Terraform environment was setup properly. To delete any infrastructure created by this 
script, use the "$ terraform destroy" command to clear out these resources in the AWS console. This script depends on the s3 bucket to operate correctly and 
both Terraform files should be placed in their appropriate folders within the hierarchical structure of the Terraform environment. The top portion of the file refers 
to the s3 bucket. 

main.tf 
-------
The code found here focuses on forming a shared container that keeps track of the current state of the Terraform environment. It stores the various metadata files 
associated with the environment inside the S3 section of the AWS account under the list of created buckets. This script is comprised of three interconnected segments 
or blocks that work together. The last two of these blocks are the s3 bucket and dynamodb table resources, while the first one appears to be a reference to the 
s3 bucket container. 

Example: Folder Hierarchy of the Terraform Environment
----------------------------------------------------------
	          Terraform 
                    / | \
	          /   |   \
                /     |     \
	       /      |      \ 
             EC2/    ?/       ?/
	      |
         EC2.tf & s3/
	      | 
            main.tf 


