provider "aws" {
  region = "us-west-1"
  allowed_account_ids = [
    "990466748045"
  ]
  assume_role {
    role_arn     = "arn:aws:iam::990466748045:role/aws-admin"
    session_name = "proxysql-poc"
  }
}

provider "aws" {
  alias  = "uw1"
  region = "us-west-1"
  allowed_account_ids = [
    "990466748045"
  ]
  assume_role {
    role_arn     = "arn:aws:iam::990466748045:role/aws-admin"
    session_name = "proxysql-poc"
  }
}

provider "aws" {
  alias  = "uw2"
  region = "us-west-2"
  allowed_account_ids = [
    "990466748045"
  ]
  assume_role {
    role_arn     = "arn:aws:iam::990466748045:role/aws-admin"
    session_name = "proxysql-poc"
  }
}
