output "instance_ips" {
  value = aws_instance.app_server[*].public_ip
}

output "instance_ip" {
  value = length(aws_instance.app_server) > 0 ? aws_instance.app_server[0].public_ip : null
}