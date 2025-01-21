# CCL Devops Demonstration Project

This project is a demo project which demonstrate the technologic capabilities of its creators.
The objective is to use Terraform, Ansible, AWS and Github actions to deploy an infrastucture.

1. Infrastructure and Kubernetes Cluster Setup

* Use Terraform to provision an EKS cluster on AWS
* Set up a multi-AZ VPC architecture for high availability
* Configure node groups with auto-scaling capabilities
* Implement AWS Load Balancer Controller
* Set up cluster networking with AWS CNI
* Create namespaces for different environments

2. CI/CD Pipeline for Containerized Applications

* Create GitHub Actions workflows to:
    Build and push Docker images to ECR
    Run container security scans
    Deploy to different EKS namespaces based on branches
    Apply Kubernetes manifests
    Run integration tests

* Implement GitOps practices using tools like ArgoCD or Flux

3. Kubernetes Application Platform

* Deploy common platform services:
    Ingress controller (nginx/traefik)
    Monitoring stack (Prometheus/Grafana)
    Logging solution (EFK/ELK stack)
    Service mesh (Istio)

* Implement horizontal pod autoscaling
* Set up pod disruption budgets
* Configure resource quotas and limits

4. Hybrid Infrastructure Management

* Use Ansible to configure worker nodes
* Create playbooks for node maintenance
* Implement cluster backup solutions
* Set up external secrets management with AWS Secrets Manager
* Configure AWS IAM roles for service accounts
* Implement cross-account access patterns

5. Microservices Application Stack

* Deploy a sample microservices application using:
    API Gateway/ALB Ingress Controller
    EKS for container orchestration
    RDS/Aurora for databases
    ElastiCache for caching
    SQS/SNS for messaging

Implement service discovery
Set up blue-green deployments

6. Multi-Region Disaster Recovery

* Create multi-region EKS clusters
* Implement cross-region data replication
* Set up Route 53 for global traffic management
* Create automated backup and restore procedures
* Implement cluster federation if needed
* Design failover procedures

7. Security and Compliance Infrastructure

* Implement pod security policies
* Set up network policies
* Configure AWS WAF with ALB/API Gateway
* Implement RBAC for Kubernetes
* Set up audit logging
* Configure security groups and NACLs
* Implement container image scanning in CI/CD

## Authors

* Guillaume Ros <gros@ccl-consulting.fr>
