# bq
## セットアップ
### サービスアカウントを使用する場合
```
gcloud auth activate-service-account bigquery@$(gcloud config get-value project).iam.gserviceaccount.com --key-file=../../../../credentials/bigquery-key.json
```

### アカウントの切り替え
```
gcloud config set account <account>
```
