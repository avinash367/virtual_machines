provider "aws" {
  region = var.AWS_REGION
}
 # VPC
resource "aws_default_vpc" "default" {}

resource "aws_instance" "bastion" {
  count                       = "${var.instance_count}"
  ami                         = var.AMI_ID
  instance_type               = var.INSTANCE_TYPE
  security_groups             = ["${aws_security_group.bastion-sg.name}"]
  key_name                    = aws_key_pair.bastion_key.key_name
  associate_public_ip_address = true
  user_data = "${file("install.sh")}"
    tags = {
    Name = "Avinash_Test"
  }
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "avinash"
  public_key = var.public_key
}
