module "terraform_state_backend" {
  source = "cloudposse/tfstate-backend/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version    = "1.5.0"
  enabled    = terraform.workspace == "default"
  namespace  = "grs"
  stage      = "terraform"
  name       = "devops-project"
  attributes = ["state"]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = true
}
