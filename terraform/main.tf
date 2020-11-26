variable credentials {}
variable project {}
variable region { default = "us-central1" }
variable zone { default = "us-central1-c" }

terraform {
  required_version = "= 0.13.5"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "= 3.47.0"
    }
  }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "hyakusho-io"

    workspaces {
      name = "gcp-sandbox"
    }
  }
}

provider "google" {
  credentials = var.credentials
  project = var.project
  region = var.region
  zone = var.zone
}

data "google_compute_image" "ubuntu_2004" {
  family = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "default" {
  name = "free"
  machine_type = "f1-micro"
  zone = var.zone

  allow_stopping_for_update = true
  labels = {
    environment = "development"
    name = "free"
    region = var.region
    zone = var.zone
  }

  boot_disk {
    initialize_params {
      size = 30
      type = "pd-standard"
      image = data.google_compute_image.ubuntu_2004.self_link
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }
}
