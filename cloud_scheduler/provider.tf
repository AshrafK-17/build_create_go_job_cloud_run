terraform {
  backend "gcs" {
    bucket = "tf-state-actionscicd"
    prefix = "prod"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = "us-central1-a"
  #credentials = "./Keys.json"
}

data "google_project" "current" {}