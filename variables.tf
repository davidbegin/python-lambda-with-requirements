variable "function_filename" {
  default     = "lambda_function"
  description = "The name of the file for your lambda function."
}

variable "function_folder" {
  default     = "code"
  description = "The folder where you lambda function code is stored."
}

variable "python_runtime" {
  default = "python3.6"
}

variable "virtualenv_name" {
  default     = "terraform-ve"
  description = "The name of the virtualenv to be created for your lambda function."
}
