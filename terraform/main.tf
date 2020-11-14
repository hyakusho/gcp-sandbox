terraform {
  required_version = "= 0.13.5"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "= 3.47.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project = var.project
  region = var.region
  zone = var.zone
}
