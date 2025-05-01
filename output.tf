output "frontend_alb_dns_name" {
  description = "Frontend ALB DNS name"
  value       = aws_lb.frontend_lb.dns_name
}

output "backend_alb_dns_name" {
  description = "Backend ALB DNS name"
  value       = aws_lb.backend_lb.dns_name
}

output "bastion_instance_id" {
  description = "Bastion Host Instance ID"
  value       = aws_instance.bastion.id
}

output "rds_endpoint" {
  description = "RDS MySQL endpoint"
  value       = aws_db_instance.main.endpoint
}