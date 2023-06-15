output "client" {
  value = aws_instance.client.public_ip
}

output "proxysql" {
  value = aws_instance.proxysql.public_ip
}

output "mysql" {
  value = aws_instance.mysql.public_ip
}

output "replica" {
  value = aws_instance.replica.public_ip
}
