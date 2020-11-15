require "google/cloud/bigquery"

def delete_dataset dataset_id = "my_empty_dataset"
  bigquery = Google::Cloud::Bigquery.new

  # Delete a dataset that does not contain any tables
  dataset = bigquery.dataset dataset_id
  dataset.delete
  puts "Dataset #{dataset_id} deleted."
end
