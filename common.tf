locals {
  common_tags = {
    "created_by" : "infrahouse/proxysql-poc" # GitHub repository that created a resource
  }
  aws_account_id        = "990466748045"
  aws_default_region    = "us-west-1"
  client_mysql_user     = "client_app"
  client_mysql_password = random_password.client_mysql_password.result
  client_mysql_db       = "appdb"
}


resource "aws_key_pair" "aleks_MediaPC" {
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "open" {
  name = "open all"
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "all"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "all"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = merge({
    Name = "open"
    },
    local.common_tags
  )
}


resource "random_password" "mysql_password" {
  length  = 16
  special = false
}

resource "random_password" "proxysql_admin_password" {
  length  = 16
  special = false
}

resource "random_password" "client_mysql_password" {
  length  = 16
  special = false
}

resource "random_password" "repl_password" {
  length  = 16
  special = false
}