# ProxySQL Sandbox

proxysql-sandbox is a terraform live module that allows quickly deploy a
sandbox ProxySQL setup.

![Untitled drawing](https://github.com/infrahouse/proxysql-sandbox/assets/1763754/95fa1ce2-3a18-42f4-8020-e541c8dff61c)

The setup includes:

* MySQL replica set: a master and one replica
* ProxySQL instance
* Client instance

The sandbox is intended for temporary deployments to test ProxySQL
versions, features. Not intended for production use.

# Usage

## AWS authentication
The module assumes that `terraform` binary has access to AWS. You can configure it in several ways.

[Config file](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

[user1]
aws_access_key_id=AKIAI44QH8DHBEXAMPLE
aws_secret_access_key=je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
```

[Environment variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

```
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-west-2
```
See other examples on the [AWS docs website](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

## Running Terraform plan

```
# make plan
```

<details>
  <summary>Sample output</summary>
  <pre>
      terraform init -no-color
    
    Initializing the backend...
    
    Initializing provider plugins...
    - terraform.io/builtin/terraform is built in to Terraform
    - Reusing previous version of hashicorp/random from the dependency lock file
    - Reusing previous version of hashicorp/template from the dependency lock file
    - Reusing previous version of hashicorp/aws from the dependency lock file
    - Using previously-installed hashicorp/aws v4.67.0
    - Using previously-installed hashicorp/random v3.5.1
    - Using previously-installed hashicorp/template v2.2.0
    
    Terraform has been successfully initialized!
    
    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.
    
    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
    set -o pipefail ; terraform plan -var-file=configuration.tfvars -no-color --out=tf.plan 2> plan.stderr | tee plan.stdout || (cat plan.stderr; exit 1)
    data.aws_ami.ubuntu: Reading...
    data.aws_ami.ubuntu: Read complete after 0s [id=ami-0e47283f03fc8c90b]
    
    Terraform used the selected providers to generate the following execution
    plan. Resource actions are indicated with the following symbols:
      + create
     <= read (data resources)
    
    Terraform will perform the following actions:
    
      # data.template_cloudinit_config.client will be read during apply
      # (config refers to values not yet known)
     <= data "template_cloudinit_config" "client" {
          + base64_encode = true
          + gzip          = true
          + id            = (known after apply)
          + rendered      = (known after apply)
    
          + part {
              + content      = (known after apply)
              + content_type = "text/cloud-config"
            }
        }
    
      # data.template_cloudinit_config.mysql will be read during apply
      # (config refers to values not yet known)
     <= data "template_cloudinit_config" "mysql" {
          + base64_encode = true
          + gzip          = true
          + id            = (known after apply)
          + rendered      = (known after apply)
    
          + part {
              + content      = (known after apply)
              + content_type = "text/cloud-config"
            }
        }
    
      # data.template_cloudinit_config.proxysql will be read during apply
      # (config refers to values not yet known)
     <= data "template_cloudinit_config" "proxysql" {
          + base64_encode = true
          + gzip          = true
          + id            = (known after apply)
          + rendered      = (known after apply)
    
          + part {
              + content      = (known after apply)
              + content_type = "text/cloud-config"
            }
        }
    
      # data.template_cloudinit_config.replica will be read during apply
      # (config refers to values not yet known)
     <= data "template_cloudinit_config" "replica" {
          + base64_encode = true
          + gzip          = true
          + id            = (known after apply)
          + rendered      = (known after apply)
    
          + part {
              + content      = (known after apply)
              + content_type = "text/cloud-config"
            }
        }
    
      # aws_instance.client will be created
      + resource "aws_instance" "client" {
          + ami                                  = "ami-0e47283f03fc8c90b"
          + arn                                  = (known after apply)
          + associate_public_ip_address          = (known after apply)
          + availability_zone                    = (known after apply)
          + cpu_core_count                       = (known after apply)
          + cpu_threads_per_core                 = (known after apply)
          + disable_api_stop                     = (known after apply)
          + disable_api_termination              = (known after apply)
          + ebs_optimized                        = (known after apply)
          + get_password_data                    = false
          + host_id                              = (known after apply)
          + host_resource_group_arn              = (known after apply)
          + iam_instance_profile                 = (known after apply)
          + id                                   = (known after apply)
          + instance_initiated_shutdown_behavior = (known after apply)
          + instance_state                       = (known after apply)
          + instance_type                        = "t3a.micro"
          + ipv6_address_count                   = (known after apply)
          + ipv6_addresses                       = (known after apply)
          + key_name                             = (known after apply)
          + monitoring                           = (known after apply)
          + outpost_arn                          = (known after apply)
          + password_data                        = (known after apply)
          + placement_group                      = (known after apply)
          + placement_partition_number           = (known after apply)
          + primary_network_interface_id         = (known after apply)
          + private_dns                          = (known after apply)
          + private_ip                           = (known after apply)
          + public_dns                           = (known after apply)
          + public_ip                            = (known after apply)
          + secondary_private_ips                = (known after apply)
          + security_groups                      = (known after apply)
          + source_dest_check                    = true
          + subnet_id                            = (known after apply)
          + tags                                 = {
              + "Name"       = "client"
              + "created_by" = "infrahouse/proxysql-poc"
            }
          + tags_all                             = {
              + "Name"       = "client"
              + "created_by" = "infrahouse/proxysql-poc"
            }
          + tenancy                              = (known after apply)
          + user_data                            = (known after apply)
          + user_data_base64                     = (known after apply)
          + user_data_replace_on_change          = false
          + vpc_security_group_ids               = (known after apply)
        }
    
      # aws_instance.mysql will be created
      + resource "aws_instance" "mysql" {
          + ami                                  = "ami-0e47283f03fc8c90b"
          + arn                                  = (known after apply)
          + associate_public_ip_address          = (known after apply)
          + availability_zone                    = (known after apply)
          + cpu_core_count                       = (known after apply)
          + cpu_threads_per_core                 = (known after apply)
          + disable_api_stop                     = (known after apply)
          + disable_api_termination              = (known after apply)
          + ebs_optimized                        = (known after apply)
          + get_password_data                    = false
          + host_id                              = (known after apply)
          + host_resource_group_arn              = (known after apply)
          + iam_instance_profile                 = (known after apply)
          + id                                   = (known after apply)
          + instance_initiated_shutdown_behavior = (known after apply)
          + instance_state                       = (known after apply)
          + instance_type                        = "t3a.micro"
          + ipv6_address_count                   = (known after apply)
          + ipv6_addresses                       = (known after apply)
          + key_name                             = (known after apply)
          + monitoring                           = (known after apply)
          + outpost_arn                          = (known after apply)
          + password_data                        = (known after apply)
          + placement_group                      = (known after apply)
          + placement_partition_number           = (known after apply)
          + primary_network_interface_id         = (known after apply)
          + private_dns                          = (known after apply)
          + private_ip                           = (known after apply)
          + public_dns                           = (known after apply)
          + public_ip                            = (known after apply)
          + secondary_private_ips                = (known after apply)
          + security_groups                      = (known after apply)
          + source_dest_check                    = true
          + subnet_id                            = (known after apply)
          + tags                                 = {
              + "Name"       = "mysql"
              + "created_by" = "infrahouse/proxysql-poc"
            }
          + tags_all                             = {
              + "Name"       = "mysql"
              + "created_by" = "infrahouse/proxysql-poc"
            }
          + tenancy                              = (known after apply)
          + user_data                            = (known after apply)
          + user_data_base64                     = (known after apply)
          + user_data_replace_on_change          = false
          + vpc_security_group_ids               = (known after apply)
        }
    
      # aws_instance.proxysql will be created
      + resource "aws_instance" "proxysql" {
          + ami                                  = "ami-0e47283f03fc8c90b"
          + arn                                  = (known after apply)
          + associate_public_ip_address          = (known after apply)
          + availability_zone                    = (known after apply)
          + cpu_core_count                       = (known after apply)
          + cpu_threads_per_core                 = (known after apply)
          + disable_api_stop                     = (known after apply)
          + disable_api_termination              = (known after apply)
          + ebs_optimized                        = (known after apply)
          + get_password_data                    = false
          + host_id                              = (known after apply)
          + host_resource_group_arn              = (known after apply)
          + iam_instance_profile                 = (known after apply)
          + id                                   = (known after apply)
          + instance_initiated_shutdown_behavior = (known after apply)
          + instance_state                       = (known after apply)
          + instance_type                        = "t3a.micro"
          + ipv6_address_count                   = (known after apply)
          + ipv6_addresses                       = (known after apply)
          + key_name                             = (known after apply)
          + monitoring                           = (known after apply)
          + outpost_arn                          = (known after apply)
          + password_data                        = (known after apply)
          + placement_group                      = (known after apply)
          + placement_partition_number           = (known after apply)
          + primary_network_interface_id         = (known after apply)
          + private_dns                          = (known after apply)
          + private_ip                           = (known after apply)
          + public_dns                           = (known after apply)
          + public_ip                            = (known after apply)
          + secondary_private_ips                = (known after apply)
          + security_groups                      = (known after apply)
          + source_dest_check                    = true
          + subnet_id                            = (known after apply)
          + tags                                 = {
              + "Name"       = "proxysql"
              + "created_by" = "infrahouse/proxysql-poc"
            }
          + tags_all                             = {
              + "Name"       = "proxysql"
              + "created_by" = "infrahouse/proxysql-poc"
            }
          + tenancy                              = (known after apply)
          + user_data                            = (known after apply)
          + user_data_base64                     = (known after apply)
          + user_data_replace_on_change          = false
          + vpc_security_group_ids               = (known after apply)
        }
    
      # aws_instance.replica will be created
      + resource "aws_instance" "replica" {
          + ami                                  = "ami-0e47283f03fc8c90b"
          + arn                                  = (known after apply)
          + associate_public_ip_address          = (known after apply)
          + availability_zone                    = (known after apply)
          + cpu_core_count                       = (known after apply)
          + cpu_threads_per_core                 = (known after apply)
          + disable_api_stop                     = (known after apply)
          + disable_api_termination              = (known after apply)
          + ebs_optimized                        = (known after apply)
          + get_password_data                    = false
          + host_id                              = (known after apply)
          + host_resource_group_arn              = (known after apply)
          + iam_instance_profile                 = (known after apply)
          + id                                   = (known after apply)
          + instance_initiated_shutdown_behavior = (known after apply)
          + instance_state                       = (known after apply)
          + instance_type                        = "t3a.micro"
          + ipv6_address_count                   = (known after apply)
          + ipv6_addresses                       = (known after apply)
          + key_name                             = (known after apply)
          + monitoring                           = (known after apply)
          + outpost_arn                          = (known after apply)
          + password_data                        = (known after apply)
          + placement_group                      = (known after apply)
          + placement_partition_number           = (known after apply)
          + primary_network_interface_id         = (known after apply)
          + private_dns                          = (known after apply)
          + private_ip                           = (known after apply)
          + public_dns                           = (known after apply)
          + public_ip                            = (known after apply)
          + secondary_private_ips                = (known after apply)
          + security_groups                      = (known after apply)
          + source_dest_check                    = true
          + subnet_id                            = (known after apply)
          + tags                                 = {
              + "Name"       = "replica"
              + "created_by" = "infrahouse/proxysql-poc"
            }
          + tags_all                             = {
              + "Name"       = "replica"
              + "created_by" = "infrahouse/proxysql-poc"
            }
          + tenancy                              = (known after apply)
          + user_data                            = (known after apply)
          + user_data_base64                     = (known after apply)
          + user_data_replace_on_change          = false
          + vpc_security_group_ids               = (known after apply)
        }
    
      # aws_key_pair.aleks_MediaPC will be created
      + resource "aws_key_pair" "aleks_MediaPC" {
          + arn             = (known after apply)
          + fingerprint     = (known after apply)
          + id              = (known after apply)
          + key_name        = (known after apply)
          + key_name_prefix = (known after apply)
          + key_pair_id     = (known after apply)
          + key_type        = (known after apply)
          + public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDpgAP1z1Lxg9Uv4tam6WdJBcAftZR4ik7RsSr6aNXqfnTj4civrhd/q8qMqF6wL//3OujVDZfhJcffTzPS2XYhUxh/rRVOB3xcqwETppdykD0XZpkHkc8XtmHpiqk6E9iBI4mDwYcDqEg3/vrDAGYYsnFwWmdDinxzMH1Gei+NPTmTqU+wJ1JZvkw3WBEMZKlUVJC/+nuv+jbMmCtm7sIM4rlp2wyzLWYoidRNMK97sG8+v+mDQol/qXK3Fuetj+1f+vSx2obSzpTxL4RYg1kS6W1fBlSvstDV5bQG4HvywzN5Y8eCpwzHLZ1tYtTycZEApFdy+MSfws5vPOpggQlWfZ4vA8ujfWAF75J+WABV4DlSJ3Ng6rLMW78hVatANUnb9s4clOS8H6yAjv+bU3OElKBkQ10wNneoFIMOA3grjPvPp5r8dI0WDXPIznJThDJO5yMCy3OfCXlu38VDQa1sjVj1zAPG+Vn2DsdVrl50hWSYSB17Zww0MYEr8N5rfFE= aleks@MediaPC"
          + tags_all        = (known after apply)
        }
    
      # aws_security_group.open will be created
      + resource "aws_security_group" "open" {
          + arn                    = (known after apply)
          + description            = "Managed by Terraform"
          + egress                 = [
              + {
                  + cidr_blocks      = [
                      + "0.0.0.0/0",
                    ]
                  + description      = ""
                  + from_port        = 0
                  + ipv6_cidr_blocks = []
                  + prefix_list_ids  = []
                  + protocol         = "-1"
                  + security_groups  = []
                  + self             = false
                  + to_port          = 0
                },
            ]
          + id                     = (known after apply)
          + ingress                = [
              + {
                  + cidr_blocks      = [
                      + "0.0.0.0/0",
                    ]
                  + description      = ""
                  + from_port        = 0
                  + ipv6_cidr_blocks = []
                  + prefix_list_ids  = []
                  + protocol         = "-1"
                  + security_groups  = []
                  + self             = false
                  + to_port          = 0
                },
            ]
          + name                   = "open all"
          + name_prefix            = (known after apply)
          + owner_id               = (known after apply)
          + revoke_rules_on_delete = false
          + tags                   = {
              + "Name"       = "open"
              + "created_by" = "infrahouse/proxysql-poc"
            }
          + tags_all               = {
              + "Name"       = "open"
              + "created_by" = "infrahouse/proxysql-poc"
            }
          + vpc_id                 = (known after apply)
        }
    
      # random_password.client_mysql_password will be created
      + resource "random_password" "client_mysql_password" {
          + bcrypt_hash = (sensitive value)
          + id          = (known after apply)
          + length      = 16
          + lower       = true
          + min_lower   = 0
          + min_numeric = 0
          + min_special = 0
          + min_upper   = 0
          + number      = true
          + numeric     = true
          + result      = (sensitive value)
          + special     = false
          + upper       = true
        }
    
      # random_password.mysql_password will be created
      + resource "random_password" "mysql_password" {
          + bcrypt_hash = (sensitive value)
          + id          = (known after apply)
          + length      = 16
          + lower       = true
          + min_lower   = 0
          + min_numeric = 0
          + min_special = 0
          + min_upper   = 0
          + number      = true
          + numeric     = true
          + result      = (sensitive value)
          + special     = false
          + upper       = true
        }
    
      # random_password.proxysql_admin_password will be created
      + resource "random_password" "proxysql_admin_password" {
          + bcrypt_hash = (sensitive value)
          + id          = (known after apply)
          + length      = 16
          + lower       = true
          + min_lower   = 0
          + min_numeric = 0
          + min_special = 0
          + min_upper   = 0
          + number      = true
          + numeric     = true
          + result      = (sensitive value)
          + special     = false
          + upper       = true
        }
    
      # random_password.repl_password will be created
      + resource "random_password" "repl_password" {
          + bcrypt_hash = (sensitive value)
          + id          = (known after apply)
          + length      = 16
          + lower       = true
          + min_lower   = 0
          + min_numeric = 0
          + min_special = 0
          + min_upper   = 0
          + number      = true
          + numeric     = true
          + result      = (sensitive value)
          + special     = false
          + upper       = true
        }
    
      # terraform_data.client_replacement will be created
      + resource "terraform_data" "client_replacement" {
          + id     = (known after apply)
          + input  = (known after apply)
          + output = (known after apply)
        }
    
      # terraform_data.proxysql_replacement will be created
      + resource "terraform_data" "proxysql_replacement" {
          + id     = (known after apply)
          + input  = (known after apply)
          + output = (known after apply)
        }
    
      # terraform_data.replacement will be created
      + resource "terraform_data" "replacement" {
          + id     = (known after apply)
          + input  = (known after apply)
          + output = (known after apply)
        }
    
      # terraform_data.replica_replacement will be created
      + resource "terraform_data" "replica_replacement" {
          + id     = (known after apply)
          + input  = (known after apply)
          + output = (known after apply)
        }
    
    Plan: 14 to add, 0 to change, 0 to destroy.
    
    Changes to Outputs:
      + client   = (known after apply)
      + mysql    = (known after apply)
      + proxysql = (known after apply)
      + replica  = (known after apply)
    
    ─────────────────────────────────────────────────────────────────────────────
    
    Saved the plan to: tf.plan
    
    To perform exactly these actions, run the following command to apply:
        terraform apply "tf.plan"

  </pre>
</details>
  
## Running Terraform apply
 
```
# make apply
```
  
The terraform output variables give IP addresses of the launched instances:
```
Outputs:

client = "3.101.62.71"
mysql = "54.177.26.133"
proxysql = "54.177.24.141"
replica = "52.53.183.3"
```
  
  
<details>
    <summary>Sample output</summary>
    <pre>
    terraform apply -auto-approve -input=false tf.plan
    random_password.proxysql_admin_password: Creating...
    random_password.client_mysql_password: Creating...
    random_password.repl_password: Creating...
    random_password.mysql_password: Creating...
    random_password.proxysql_admin_password: Creation complete after 0s [id=none]
    random_password.mysql_password: Creation complete after 0s [id=none]
    random_password.repl_password: Creation complete after 0s [id=none]
    random_password.client_mysql_password: Creation complete after 0s [id=none]
    data.template_cloudinit_config.mysql: Reading...
    data.template_cloudinit_config.mysql: Read complete after 0s [id=4134407709]
    terraform_data.replacement: Creating...
    terraform_data.replacement: Creation complete after 0s [id=2291c016-d347-3bb2-09e1-af156a284ef9]
    aws_key_pair.aleks_MediaPC: Creating...
    aws_security_group.open: Creating...
    aws_key_pair.aleks_MediaPC: Creation complete after 1s [id=terraform-20230615153555289800000001]
    aws_security_group.open: Creation complete after 2s [id=sg-0846e3885d3176b6d]
    aws_instance.mysql: Creating...
    aws_instance.mysql: Still creating... [10s elapsed]
    aws_instance.mysql: Creation complete after 12s [id=i-08a53ad9f15bb0c95]
    data.template_cloudinit_config.replica: Reading...
    data.template_cloudinit_config.proxysql: Reading...
    data.template_cloudinit_config.replica: Read complete after 0s [id=2643013189]
    data.template_cloudinit_config.proxysql: Read complete after 0s [id=3752395247]
    terraform_data.replica_replacement: Creating...
    terraform_data.proxysql_replacement: Creating...
    terraform_data.proxysql_replacement: Creation complete after 0s [id=c66c03c9-b60d-7aa3-a557-eb7c9526a7ed]
    terraform_data.replica_replacement: Creation complete after 0s [id=72f631e6-6320-9bfd-4be4-2142d2205d51]
    aws_instance.replica: Creating...
    aws_instance.proxysql: Creating...
    aws_instance.replica: Still creating... [10s elapsed]
    aws_instance.proxysql: Still creating... [10s elapsed]
    aws_instance.replica: Creation complete after 12s [id=i-0a90867fc97ab2968]
    aws_instance.proxysql: Creation complete after 12s [id=i-076189defd34b263d]
    data.template_cloudinit_config.client: Reading...
    data.template_cloudinit_config.client: Read complete after 0s [id=3585009514]
    terraform_data.client_replacement: Creating...
    terraform_data.client_replacement: Creation complete after 0s [id=c15ce275-5d6f-8bbe-1664-01f51cbbc465]
    aws_instance.client: Creating...
    aws_instance.client: Still creating... [10s elapsed]
    aws_instance.client: Creation complete after 12s [id=i-0112d94b26260ef30]
    Apply complete! Resources: 14 added, 0 changed, 0 destroyed.
    Outputs:
    client = "3.101.62.71"
    mysql = "54.177.26.133"
    proxysql = "54.177.24.141"
    replica = "52.53.183.3"
    </pre>
</details>

## Accessing Instances
 
Terraform installs your key from `~/.ssh/id_rsa.pub` in the instances' `/home/ubuntu/.ssh/authorized_keys`.
  
So if you have the respective private SSH key and there were no errors up until now this should work:

```
# ssh -l ubuntu 3.101.62.71
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1037-aws x86_64)

...
ubuntu@ip-172-31-22-208:~$
```

## After you done
  
When you don't need the sandbox anymore run `make destroy` to remove created resources.
```
# make destroy
```
