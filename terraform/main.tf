terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
# Credentials only needs to be set if you do not have the GOOGLE_APPLICATION_CREDENTIALS set
  #credentials = "./keys/nyc-de-gcp-8e0479ba1c9d.json"
  project = "nyc-de-gcp-412823"
  region  = "us-central1"
}



resource "google_storage_bucket" "data-lake-bucket" {
  name          = "nyc-de-gcp-2024-01"
  location      = "US"
  # Optional, but recommended settings:
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }

  force_destroy = true
}


resource "google_bigquery_dataset" "dataset" {
  dataset_id = "data_NYC_2021123"
  project    = "nyc-de-gcp-412823"
  location   = "US"
}