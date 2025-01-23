output "load_balancer_public_ip" {
  description = "The public IP of the load balancer"
  value       = aws_lb.eks.dns_name
}
