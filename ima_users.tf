provider "aws" {
  region		  = "us-west-2"
  shared_credentials_file = "/home/garrett/.aws/credentials"
  profile		  = "default"
}

resource "aws_iam_group" "project1_team" {
  name = "project1_team"
  path = "/cit480/"
}


variable "username" {
  type = "list"
  default = ["mark", "artur", "luis", "garrett"]
}

resource "aws_iam_user" "user_creation" {
  count = "${length(var.username)}"
  name = "${element(var.username, count.index)}"
  path = "/cit480/"
}
