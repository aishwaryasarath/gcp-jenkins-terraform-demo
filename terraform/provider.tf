terraform {
  required_providers {
    google = { source = "hashicorp/google", version = "~> 5.0" }
    random = { source = "hashicorp/random", version = "~> 3.6" }
  }
}
provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_json)
}
