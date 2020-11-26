#!/bin/bash

BASEDIR=$(cd $(dirname $0)/.. && pwd && cd - >& /dev/null)
PROJECT=$(gcloud config get-value core/project)
LOGFILE=/tmp/$(basename ${0}).log.$$

create_service_account() {
  service_account=$1
  echo "$service_account"

  roles=()
  case $service_account in
    terraform)
      roles=(compute.admin)
      ;;
    bigquery)
      roles=(bigquery.dataEditor bigquery.jobUser)
      ;;
    ansible)
      roles=(compute.osAdminLogin compute.instanceAdmin compute.instanceAdmin.v1)
      ;;
    *)
      echo "NotSupportedServiceAccountException : $service_account"
      exit 1
  esac

  # exists?
  gcloud iam service-accounts describe ${service_account}@${PROJECT}.iam.gserviceaccount.com > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    # no exists (create a service account)
    gcloud iam service-accounts create $service_account --display-name $service_account
    gcloud iam service-accounts keys create $BASEDIR/credentials/${service_account}-key.json \
      --iam-account ${service_account}@${PROJECT}.iam.gserviceaccount.com
  fi

  # create/update iam-roles
  set -eo pipefail
  for role in "${roles[@]}"; do
    echo "- $role"
    gcloud projects add-iam-policy-binding $PROJECT \
      --member serviceAccount:${service_account}@${PROJECT}.iam.gserviceaccount.com \
      --role roles/$role >> $LOGFILE 2>&1
  done
  set +eo pipefail

  # gcs settings
  if [ $service_account = "terraform" ]; then
    bucket="gs://hyakusho-io-terraform"
    gsutil mb -l us-central1 -b on $bucket
    gsutil versioning on $buckeet
    gsutil iam ch \
      serviceAccount:${service_account}@${PROJECT}.iam.gserviceaccount.com:roles/storage.objectAdmin \
      $bucket
  fi
}

main() {
  service_accounts=(terraform bigquery ansible)
  for i in "${service_accounts[@]}"; do
    create_service_account $i
  done 
}

main
