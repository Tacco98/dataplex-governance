resource "google_dataplex_lake" "lake1" {
  name     = "sales-lake"
  location = var.region
}

resource "google_dataplex_zone" "raw_zone" {
  name     = "raw-zone"
  lake     = google_dataplex_lake.lake1.name
  location = var.region
  type     = "RAW"

  discovery_spec {
    enabled = false
  }

  resource_spec {
    location_type = "SINGLE_REGION"
  }
}

resource "google_dataplex_asset" "data_asset" {
  name     = "asset1"
  location = var.region

  lake          = google_dataplex_lake.lake1.name
  dataplex_zone = google_dataplex_zone.raw_zone.name

  discovery_spec {
    enabled = false
  }

  resource_spec {
    name = "projects/${var.project_id}/buckets/${google_storage_bucket.data_lake1.id}"
    type = "STORAGE_BUCKET"
  }
}
