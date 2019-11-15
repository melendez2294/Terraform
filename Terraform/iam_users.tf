terraform {
    backend  "s3" {
    region         = "us-west-2"
    bucket         = "cit480groupbuck"
    key            = "ec2/terraform.tfstate" 
    dynamodb_table = "tf-state-lock"
    }
} 

provider "aws" {
  region		  = "us-west-2"
  profile		  = "default"
}

variable "keybase" {
  type    = "list"
  default = ["keybase:MLawton", "keybase:atarverdyan", "keybase:melendez2294", "keybase:garrettc777"]
}

variable "username" {
  type    = "list"
  default = ["mark", "artur", "luis", "gary"]
}

resource "aws_iam_group" "thegroup" {
  name   = "thegroup"
  path   = "/cit480/"
}

resource "aws_iam_user" "user_creation" {
  count  = "${length(var.username)}"
  name   = "${element(var.username, count.index)}"
  path   = "/cit480/"
}

resource "aws_iam_user_group_membership" "add" {
  count = "${length(var.username)}"
  user = "${element(var.username, count.index)}"

  groups = [
    "${aws_iam_group.thegroup.name}",
  ]
}

resource "aws_iam_group_policy" "cit480policy" {
  name = "cit480policy"
  group = "${aws_iam_group.thegroup.id}"
  
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
POLICY
}

 resource "aws_iam_user_login_profile" "loginprofile" {
  count  = "${length(var.username)}"
  user = "${element(var.username, count.index)}"
  pgp_key = "${element(var.keybase, count.index)}"
}

output "password" {
  value = "${aws_iam_user_login_profile.loginprofile.*.encrypted_password}"
}

