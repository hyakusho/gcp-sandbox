from google.cloud import bigquery

client = bigquery.Client()

query_job = client.query(
    "SELECT country_name from `bigquery-public-data.utility_us.country_code_iso`",
    # Explicitly force job execution to be routed to a specific processing
    # location.
    location="US",
    # Specify a job configuration to set optional job resource properties.
    job_config=bigquery.QueryJobConfig(
        labels={"example-label": "example-value"}, maximum_bytes_billed=1000000
    ),
    # The client libraries automatically generate a job ID. Override the
    # generated ID with either the job_id_prefix or job_id parameters.
    job_id_prefix="code_example_",
)   # Make an API request.

print("Started job: {}".format(query_job.job_id))

job_id = query_job.job_id
location = 'US'
job = client.get_job(job_id, location=location)
print("Details for job {} running in {}:".format(job_id, location))
print(
    "\tType: {}\n\tState: {}\n\tCreated: {}".format(
        job.job_type, job.state, job.created
    )
)
