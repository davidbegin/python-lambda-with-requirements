output "invocation_cmd" {
  value = "\naws lambda invoke --invocation-type RequestResponse --function-name ${var.function_name} --region ${var.region} --log-type Tail output.txt | jq .LogResult | sed 's/\"//g' | base64 --decode"
}                                                      
