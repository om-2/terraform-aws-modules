resource "aws_instance" "instance" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  key_name = "${var.key_name}"
  associate_public_ip_address = "${var.assign_public_ip}"
  source_dest_check = "${var.source_dest_check}"
  ebs_optimized = "${var.ebs_optimized}"
  iam_instance_profile = "${var.iam_instance_profile}"

  vpc_security_group_ids = [ "${var.security_group_ids}" ]

  tags {
    Name = "${var.fqdn}"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.root_volume_size}"
    delete_on_termination = "true"
  }

}

resource "null_resource" "provision" {
  connection {
    user = "${var.ami_user}"
    timeout = "1m"
    host = "${aws_instance.instance.private_ip}"
    bastion_host = "${var.bastion_host}"
    bastion_user = "${var.bastion_user}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ${var.fqdn}"
    ]
  }

  depends_on = [
    "aws_instance.instance"
  ]

  triggers {
    instance_id = "${aws_instance.instance.id}"
    fqdn = "${var.fqdn}"
  }
}

output "private_ip" { value = "${aws_instance.instance.private_ip}" }
output "id" { value = "${aws_instance.instance.id}" }
