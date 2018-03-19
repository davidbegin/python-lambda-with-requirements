provider "aws" {
  region  = "${var.region}"
}

module "lambda_zip" {
  source = "git@github.com:davidbegin/python-lambda-with-requirements.git"

  function_filename = "${var.function_filename}"
}

resource "aws_lambda_function" "test_lambda" {
  function_name = "${var.function_name}"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "${var.function_filename}.lambda_handler"
  runtime       = "python3.6"

  filename         = "${module.lambda_zip.filename}"
  source_code_hash = "${module.lambda_zip.source_code_hash}"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "test_iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
