variable "project_id" {
  type        = string
  description = "The project name to use."
  default     = "eco-spirit-404410"
}

variable "region" {
  type        = string
  description = "The region where resources are created."
  default     = "us-central1"
}

variable "COMMIT_HASH" {
  type        = string
  description = "short commit SHA"
  default     = "0ab7074e5e52"
}

