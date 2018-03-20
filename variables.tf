variable "function_filename" {
  default     = "lambda_function"
  description = "The name of the file for your lambda function."
}

variable "function_folder" {
  description = "The folder where you lambda function code is stored."
}

variable "python_runtime" {
  default = "python3.6"
}
