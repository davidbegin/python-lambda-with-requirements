output "source_code_hash" {
  value = "${data.archive_file.lambda_archive.output_base64sha256}"
}

output "filename" {
  value = "${path.module}/tmp/${local.zip_name}"
}
