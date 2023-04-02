resource "aws_iam_instance_profile" "main" {
  name = "ec2.instance-profile.${var.name}"

  tags = var.tags
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "main" {
  name               = "ec2.role.${var.name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = var.tags
}
