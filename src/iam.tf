locals {
  policies_to_attach = toset([
    "service-role/AmazonECSTaskExecutionRolePolicy",
    "service-role/AmazonEC2ContainerServiceforEC2Role",
    "AmazonSSMManagedInstanceCore"
  ])
}

resource "aws_iam_instance_profile" "instance" {
  name = var.md_metadata.name_prefix
  role = var.md_metadata.name_prefix
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "instance" {
  name = var.md_metadata.name_prefix
  path = "/"

  assume_role_policy = data.aws_iam_policy_document.assume.json
}

data "aws_partition" "current" {}

resource "aws_iam_role_policy_attachment" "instance" {
  for_each   = local.policies_to_attach
  role       = aws_iam_role.instance.name
  policy_arn = format("arn:%s:iam::aws:policy/%s", data.aws_partition.current.partition, each.value)
  depends_on = [
    aws_iam_role.instance
  ]
}
