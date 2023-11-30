terraform {
  required_version = ">= 1.6.1"
  backend "gcs" {
    bucket = "tf-state-actionscicd"
    prefix = "prod"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = "us-central1-a"
  #credentials = "./Keys.json"
}

#data "google_project" "current" {}