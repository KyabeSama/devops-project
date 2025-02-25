terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    region  = "us-east-1"
    bucket  = "grs-terraform-devops-project-state"
    key     = "terraform.tfstate"
    profile = ""
    encrypt = "true"

    dynamodb_table = "grs-terraform-devops-project-state-lock"
  }
}
