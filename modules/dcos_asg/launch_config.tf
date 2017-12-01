data "aws_ami" "coreos" {
  most_recent = true
  owners      = ["595879546273"]

  filter {
    name   = "name"
    values = ["CoreOS-stable-*-hvm"]
  }
}

locals {
  cloud_config_def = "${path.module}/templates/userdata.tpl"
  cloud_template   = "${coalesce(var.cloud_config_template, file(local.cloud_config_def))}"
}

data "template_file" "userdata" {
  template = "${local.cloud_template}"

  vars {
    role              = "${var.dcos_role}"
    dcos_version      = "${var.dcos_version}"
    cluster_name      = "${var.cluster_name}"
    bucket_name       = "${var.bucket_name}"
    dcos_install_path = "${var.dcos_install_path}"
  }
}

resource "aws_launch_configuration" "cluster" {
  name_prefix                 = "${coalesce(var.group_prefix, "dcos-${var.cluster_name}-${var.dcos_role}-")}"
  image_id                    = "${coalesce(var.coreos_ami, data.aws_ami.coreos.id)}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${aws_iam_instance_profile.cluster.name}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  spot_price                  = "${var.spot_price}"

  user_data = "${data.template_file.userdata.rendered}"

  security_groups = [
    "${var.default_security_group}",
    "${var.security_groups}",
  ]

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.root_volume_size}"
  }

  ephemeral_block_device {
    device_name  = "/dev/sdb"
    virtual_name = "ephemeral0"
  }

  ephemeral_block_device {
    device_name  = "/dev/sdc"
    virtual_name = "ephemeral1"
  }

  ephemeral_block_device {
    device_name  = "/dev/sdd"
    virtual_name = "ephemeral2"
  }

  ephemeral_block_device {
    device_name  = "/dev/sde"
    virtual_name = "ephemeral3"
  }

  lifecycle {
    create_before_destroy = true
  }
}
