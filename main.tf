terraform {
  backend "gcs" {}
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

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

module "activate_apis" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "14.1.0"

  project_id = var.project_id

  activate_apis = [
    "compute.googleapis.com",
    "iam.googleapis.com",
  ]
}
