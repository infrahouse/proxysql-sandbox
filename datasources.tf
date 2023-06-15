data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

locals {
  proxysql_admin_user = "admin"
  repl_user = "repl"
  userdata_mysql = format(
    "#cloud-config\n%s",
    yamlencode(
      {
        "write_files" : [
          {
            content : templatefile(
              "${path.module}/files/mysqld.cnf.tfpl",
              {
                server_id = 1
                read_only = "OFF"
              }
            ),
            path : "/etc/mysql/mysql.conf.d/mysqld.cnf"
          },
          {
            content : templatefile(
              "${path.module}/files/provision_mysql.sh.tfpl",
              {
                client_mysql_user     = local.client_mysql_user
                client_mysql_password = local.client_mysql_password
                client_mysql_db       = local.client_mysql_db
                mysql_password        = random_password.mysql_password.result
                repl_user             = local.repl_user
                repl_password         = random_password.repl_password.result
              }
            ),
            path : "/usr/local/bin/provision.sh"
            permissions : "0o700",
          },
          {
            content : templatefile(
              "${path.module}/files/.my.cnf.tfpl",
              {
                mysql_password = random_password.mysql_password.result
              }
            ),
            path : "/root/.my.cnf"
            permissions : "0o600",
          },
        ]
        packages : [
          "mysql-server",
          "net-tools"
        ]
        runcmd : [
          "/usr/local/bin/provision.sh"
        ]
      }
    )
  )

  userdata_replica = format(
    "#cloud-config\n%s",
    yamlencode(
      {
        "write_files" : [
          {
            content : templatefile(
              "${path.module}/files/mysqld.cnf.tfpl",
              {
                server_id = 2
                read_only = "ON"
              }
            ),
            path : "/etc/mysql/mysql.conf.d/mysqld.cnf"
          },
          {
            content : templatefile(
              "${path.module}/files/provision_replica.sh.tfpl",
              {
                mysql_server          = aws_instance.mysql.private_ip
                repl_user             = local.repl_user
                repl_password         = random_password.repl_password.result
              }
            ),
            path : "/usr/local/bin/provision.sh"
            permissions : "0o700",
          },
          {
            content : templatefile(
              "${path.module}/files/.my.cnf.tfpl",
              {
                mysql_password = random_password.mysql_password.result
              }
            ),
            path : "/root/.my.cnf"
            permissions : "0o600",
          },
        ]
        packages : [
          "mysql-server",
          "net-tools"
        ]
        runcmd : [
          "/usr/local/bin/provision.sh"
        ]
      }
    )
  )
  userdata_proxysql = format(
    "#cloud-config\n%s",
    yamlencode(
      {
        "write_files" : [
          {
            content : templatefile(
              "${path.module}/files/provision_proxysql.sh.tfpl",
              {
#                proxysql_version = "2.5.2"
                proxysql_version = "2.4.3"
              }
            ),
            path : "/usr/local/bin/provision.sh"
            permissions : "0o700",
          },
          {
            content : templatefile(
              "${path.module}/files/proxysql.cnf.tfpl",
              {
                proxysql_admin_user     = local.proxysql_admin_user
                proxysql_admin_password = random_password.proxysql_admin_password.result
                mysql_server            = aws_instance.mysql.private_ip
                client_mysql_user       = local.client_mysql_user
                client_mysql_password   = local.client_mysql_password
              }
            ),
            path : "/etc/proxysql.cnf"
            permissions : "0o600",
          },
          {
            content : templatefile(
              "${path.module}/files/.proxysql.my.cnf.tfpl",
              {
                proxysql_admin_user     = local.proxysql_admin_user
                proxysql_admin_password = random_password.proxysql_admin_password.result
              }
            ),
            path : "/root/.my.cnf"
            permissions : "0o600",
          },
        ]
        packages : [
          "mysql-client",
          "net-tools"
        ]
        runcmd : [
          "/usr/local/bin/provision.sh",
          "systemctl restart proxysql"
        ]
      }
    )
  )

  userdata_client = format(
    "#cloud-config\n%s",
    yamlencode(
      {
        "write_files" : [
          {
            content : templatefile(
              "${path.module}/files/provision_client.sh.tfpl", {}
            ),
            path : "/usr/local/bin/provision.sh"
            permissions : "0o700",
          },
          {
            content : templatefile(
              "${path.module}/files/.client.my.cnf.tfpl",
              {
                client_mysql_user     = local.client_mysql_user
                client_mysql_password = local.client_mysql_password
                proxysql_ip           = aws_instance.proxysql.private_ip
              }
            ),
            path : "/root/.my.cnf"
            permissions : "0o600",
          },
        ]
        packages : [
          "mysql-client",
          "net-tools"
        ]
        runcmd : [
          "/usr/local/bin/provision.sh",
        ]
      }
    )
  )

}

data "template_cloudinit_config" "mysql" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = local.userdata_mysql
  }
}

data "template_cloudinit_config" "replica" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = local.userdata_replica
  }
}

data "template_cloudinit_config" "proxysql" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = local.userdata_proxysql
  }
}

data "template_cloudinit_config" "client" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = local.userdata_client
  }
}

