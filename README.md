# CCL Devops Demonstration Project

This project is a demo project which demonstrate the technologic skills of its creators.
The objective is to use Terraform, Ansible, AWS, Kubernetes and Github actions to deploy an infrastucture.

1. Infrastructure and Kubernetes Cluster Setup

* Use Terraform to provision an EKS cluster on AWS
* Set up a multi-AZ VPC architecture for high availability
* Configure node groups with auto-scaling capabilities
* Implement AWS Load Balancer Controller

2. Kubernetes Application Platform

* Deploy common platform services:
    Ingress controller (nginx)
    Monitoring stack (Prometheus/Grafana)
    Service mesh (Istio)

1. CI/CD Pipeline for Containerized Applications

* Create GitHub Actions workflows to:
    Build and push Docker images to ECR
    Run container security scans
    Apply Kubernetes manifests
    Run integration tests

* Implement GitOps practices using tools like ArgoCD or Flux

## Authors

* Guillaume Ros <gros@ccl-consulting.fr>
