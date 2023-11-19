output "instance_id" {
  value       = aws_instance.app_server.id
}

output "instance_id_with_comment" {
  value = "The Instance ID is ${aws_instance.app_server.id}"
}

output "instance_id_sensitive" {
  value = aws_instance.app_server.id
  sensitive = true
}

output "instance_public_ip" {
  value       = aws_instance.app_server.public_ip
}
