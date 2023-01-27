terraform {
  required_version = "1.3.7"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.50.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.50.0"
    }
  }
}

module "activate_apis" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "14.1.0"

  project_id = var.project_id

  activate_apis = [
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudrun.googleapis.com",
    "compute.googleapis.com",
    "firebase.googleapis.com",
    "firebasestorage.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "secretmanager.googleapis.com",
    "vpcaccess.googleapis.com",
  ]
}
