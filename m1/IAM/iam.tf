
resource "aws_iam_role" "firehose_role" {
  name = "firehose_test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}















resource "aws_iam_role_policy" "role_policy" {
  name = "role_policy"
  role = aws_iam_role.ec2_role.id

  policy = file(assumerole_policy.json)
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = file(role.json)
}


resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_role_policy.role_policy.arn
}


resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}