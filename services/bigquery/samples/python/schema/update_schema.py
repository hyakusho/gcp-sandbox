from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()

# TODO(developer): Set table_id to the ID of the table
#                  to add an empty column.
# table_id = "your-project.your_dataset.your_table_name"

table = client.get_table(table_id)  # Make an API request.

original_schema = table.schema
new_schema = original_schema[:]  # Creates a copy of the schema.
new_schema.append(bigquery.SchemaField("phone", "STRING"))

table.schema = new_schema
table = client.update_table(table, ["schema"])  # Make an API request.

if len(table.schema) == len(original_schema) + 1 == len(new_schema):
    print("A new column has been added.")
else:
    print("The column has not been added.")
