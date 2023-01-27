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
    "cloudbuild.googleapis.com",
    "cloudrun.googleapis.com",
    "firebase.googleapis.com",
    "firebasestorage.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
  ]
}

resource "google_service_account" "default" {
  account_id   = "service_account_id"
  display_name = "Service Account"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e0-medium"
  zone         = "${var.region}-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}