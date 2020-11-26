# gcp-sandbox

## セットアップ
### プロジェクトの作成
```
gcloud auth login
gcloud config configurations create gcp-sandbox
gcloud config set account <account>
gcloud config set project <project-id>
gcloud config set compute/region <region>
gcloud config set compute/zone <zone>
```

### サービスアカウントの作成
```
bin/create_service_accounts.sh
```

### Terraform
```
cd terraform
tfenv install
terraform init
terraform plan
terraform apply
```
