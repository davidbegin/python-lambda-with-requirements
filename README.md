## python-lambda-with-requirements 

A Terraform module for taking a single python file and requirements file and zipping them together for a Lambda function.

```hcl
variable "function_filename" {
  default = "lambda_function"
}

module "lambda_zip" {
  source = "git@github.com:davidbegin/python-lambda-with-requirements.git"
  
  function_filename = "${var.function_filename}"
}

resource "aws_lambda_function" "test_lambda" {
  function_name = "test_function"
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| function_filename | The name of the file for your lambda function. | string | `lambda_function` | no |
| function_folder | The folder where you lambda function code is stored. | string | `code` | no |
| python_runtime |  | string | `python3.6` | no |
| virtualenv_name | The name of the virtualenv to be created for your lambda function. | string | `terraform-ve` | no |

## Outputs

| Name | Description |
|------|-------------|
| filename |  |
| source_code_hash |  |

