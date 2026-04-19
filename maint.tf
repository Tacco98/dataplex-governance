resource "google_storage_bucket" "data_lake1" {
  name     = "${var.project_id}-data-lake"
  location = var.region

  uniform_bucket_level_access = true
}

resource "google_bigquery_dataset" "dataset1" {
  dataset_id = "sales_data"
  location   = var.region
}

resource "google_bigquery_table" "transactions" {
  dataset_id = google_bigquery_dataset.dataset1.dataset_id
  table_id   = "transactions"

  schema = <<EOF
[
    {"name": "id", "type": "STRING"},
    {"name": "amount", "type": "FLOAT"},
    {"name": "timestamp", "type": "TIMESTAMP"}
]
EOF
}