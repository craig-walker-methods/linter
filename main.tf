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

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}
