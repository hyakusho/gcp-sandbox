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

resource "google_compute_instance" "free" {
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

#resource "google_compute_instance" "datadog" {
#  name = "datadog"
#  machine_type = "e2-small"
#  zone = var.zone
#
#  allow_stopping_for_update = true
#  labels = {
#    environment = "development"
#    name = "datadog"
#    region = var.region
#    zone = var.zone
#  }
#
#  boot_disk {
#    initialize_params {
#      size = 30
#      type = "pd-standard"
#      image = data.google_compute_image.ubuntu_2004.self_link
#    }
#  }
#
#  network_interface {
#    network = "default"
#
#    access_config {}
#  }
#
#  scheduling {
#    preemptible = true
#    automatic_restart = false
#  }
#}
#
#resource "google_storage_bucket" "bigquery" {
#  name = "hyakusho-io-bigquery"
#  location = var.region
#  force_destroy = true
#  uniform_bucket_level_access = true
#
#  versioning {
#    enabled = true
#  }
#}
#
#resource "google_storage_bucket_iam_binding" "bigquery" {
#  bucket = google_storage_bucket.bigquery.name
#  role = "roles/storage.objectAdmin"
#  members = [
#    "serviceAccount:bigquery@${var.project}.iam.gserviceaccount.com"
#  ]
#}
