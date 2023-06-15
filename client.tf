resource "terraform_data" "client_replacement" {
  input = data.template_cloudinit_config.client.rendered
}

resource "aws_instance" "client" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.micro"
  key_name      = aws_key_pair.aleks_MediaPC.key_name
  vpc_security_group_ids = [
    aws_security_group.open.id
  ]
  user_data_base64 = data.template_cloudinit_config.client.rendered
  tags = merge(
    {
      Name = "client"
    },
    local.common_tags
  )
  lifecycle {
    replace_triggered_by = [
      terraform_data.client_replacement
    ]
  }
}
