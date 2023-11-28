data "google_compute_default_service_account" "default" {
}


resource "google_cloud_run_v2_job" "default" {
  name     = "cloudrun-job"
  location = var.region

  template {
    template {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/cloud-run-source-deploy/job-helloworld:latest"
      }
      #max_retries = 3
      #timeout = 10
    }
  }

  lifecycle {
    ignore_changes = [
      launch_stage,
    ]
  }
}

resource "google_cloud_scheduler_job" "job" {
  provider         = google-beta
  name             = "schedule-job"
  description      = "test http job"
  schedule         = "*/2 * * * *"
  time_zone        = "Asia/Kolkata"
  attempt_deadline = "320s"
  region           = var.region
  project          = var.project_id

  retry_config {
    retry_count = 3
  }

  http_target {
    http_method = "POST"
    uri         = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project_id}/jobs/job-helloworld:run"

    oauth_token {
      service_account_email = data.google_compute_default_service_account.default.email
    }
  }

}


