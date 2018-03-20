locals {
  tmp_folder      = "${path.module}/tmp"
  function_folder = "${path.root}/${var.function_folder}"
  site_packages   = "${local.virtualenv}/lib/${var.python_runtime}/site-packages"
  zip_name        = "${var.function_folder}.zip"
  virtualenv      = "${var.function_folder}-ve"
}

data "archive_file" "lambda_archive" {
  source_dir  = "${local.tmp_folder}/${var.function_folder}"
  output_path = "${local.tmp_folder}/${local.zip_name}"
  type        = "zip"

  depends_on = ["null_resource.create_lambda_zip"]
}

resource "null_resource" "create_lambda_zip" {
  triggers = {
    lambda_code = "${sha1(file("${local.function_folder}/${var.function_filename}.py"))}"
    requirements = "${sha1(file("${local.function_folder}/requirements.in"))}"
  }

  provisioner "local-exec" {
    command = <<EOF
      rm -rf ${local.tmp_folder}

      mkdir ${local.tmp_folder}

      rm -rf ${local.function_folder}/${local.virtualenv}

      cd ${local.function_folder}

      virtualenv -p ${var.python_runtime} ${local.virtualenv}

      source ${local.virtualenv}/bin/activate

      pip install -r requirements.in

      cp ${var.function_filename}.py ${local.site_packages}/${var.function_filename}.py

      mv ${local.site_packages} ${local.tmp_folder}/${var.function_folder}

      rm -rf ${local.function_folder}/${local.virtualenv}
EOF
  }
}
