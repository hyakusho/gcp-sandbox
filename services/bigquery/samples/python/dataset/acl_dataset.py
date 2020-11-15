from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()

# TODO(developer): Set dataset_id to the ID of the dataset to fetch.
# dataset_id = 'your-project.your_dataset'

dataset = client.get_dataset(dataset_id)  # Make an API request.

entry = bigquery.AccessEntry(
    role="READER",
    entity_type="userByEmail",
    entity_id="sample.bigquery.dev@gmail.com",
)

entries = list(dataset.access_entries)
entries.append(entry)
dataset.access_entries = entries

dataset = client.update_dataset(dataset, ["access_entries"])  # Make an API request.

full_dataset_id = "{}.{}".format(dataset.project, dataset.dataset_id)
print(
    "Updated dataset '{}' with modified user permissions.".format(full_dataset_id)
)
