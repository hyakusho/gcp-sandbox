require "google/cloud/bigquery"

def create_dataset dataset_id = "my_dataset", location = "US"
  bigquery = Google::Cloud::Bigquery.new

  # Create the dataset in a specified geographic location
  bigquery.create_dataset dataset_id, location: location

  puts "Created dataset: #{dataset_id}"
end
