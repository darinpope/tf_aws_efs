resource "aws_efs_file_system" "efs" {
  creation_token = "${var.efs_name}"
  performance_mode = "maxIO"
  tags {
    Name = "${var.efs_name}"
    managed_by = "Terraform"
  }
}

resource "aws_efs_mount_target" "efs" {
  count = "${length(var.private_subnet_ids)}"
  file_system_id = "${aws_efs_file_system.efs.id}"
  subnet_id = "${var.private_subnet_ids[count.index]}"
  security_groups = [
    "${var.security_group}"
  ]
}