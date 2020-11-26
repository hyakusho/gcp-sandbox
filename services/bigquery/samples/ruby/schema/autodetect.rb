require "google/cloud/bigquery"

def load_table_gcs_json_autodetect dataset_id = "your_dataset_id"
  bigquery = Google::Cloud::Bigquery.new
  dataset  = bigquery.dataset dataset_id
  gcs_uri  = "gs://cloud-samples-data/bigquery/us-states/us-states.json"
  table_id = "us_states"

  load_job = dataset.load_job table_id,
                              gcs_uri,
                              format:     "json",
                              autodetect: true
  puts "Starting job #{load_job.job_id}"

  load_job.wait_until_done! # Waits for table load to complete.
  puts "Job finished."

  table = dataset.table table_id
  puts "Loaded #{table.rows_count} rows to table #{table.id}"
end
