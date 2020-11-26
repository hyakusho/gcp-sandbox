#!/usr/bin/env bash

BASEDIR=$(cd $(dirname $0)/.. && pwd && cd - >& /dev/null)
PROJECT=$(gcloud config get-value core/project)
LOGFILE=/tmp/$(basename ${0}).log

output_logfile() {
  cat $LOGFILE
}

exists_service_account() {
  SERVICE_ACCOUNT=$1
  gcloud iam service-accounts describe ${SERVICE_ACCOUNT}@${PROJECT}.iam.gserviceaccount.com > /dev/null 2>&1
}

create_service_account_bigquery() {
  SERVICE_ACCOUNT=bigquery
  exists_service_account $SERVICE_ACCOUNT
  if [ $? -ne 0 ]; then
    gcloud iam service-accounts create $SERVICE_ACCOUNT --display-name $SERVICE_ACCOUNT
    gcloud iam service-accounts keys create $BASEDIR/credentials/${SERVICE_ACCOUNT}-key.json \
      --iam-account ${SERVICE_ACCOUNT}@${PROJECT}.iam.gserviceaccount.com
  fi

  set -eo pipefail
  gcloud projects add-iam-policy-binding $PROJECT \
    --member serviceAccount:${SERVICE_ACCOUNT}@${PROJECT}.iam.gserviceaccount.com \
    --role roles/bigquery.dataEditor > $LOGFILE
  gcloud projects add-iam-policy-binding $PROJECT \
    --member serviceAccount:${SERVICE_ACCOUNT}@${PROJECT}.iam.gserviceaccount.com \
    --role roles/bigquery.jobUser > $LOGFILE
}

create_service_account_terraform() {
  SERVICE_ACCOUNT=terraform
  exists_service_account $SERVICE_ACCOUNT
  if [ $? -ne 0 ]; then
    gcloud iam service-accounts create $SERVICE_ACCOUNT --display-name $SERVICE_ACCOUNT
    gcloud iam service-accounts keys create $BASEDIR/credentials/${SERVICE_ACCOUNT}-key.json \
      --iam-account ${SERVICE_ACCOUNT}@${PROJECT}.iam.gserviceaccount.com
  fi

  set -eo pipefail
  gcloud projects add-iam-policy-binding $PROJECT \
    --member serviceAccount:${SERVICE_ACCOUNT}@${PROJECT}.iam.gserviceaccount.com \
    --role roles/compute.admin > $LOGFILE
}

main() {
  create_service_account_terraform
  create_service_account_bigquery
  output_logfile
}

main
