# データセット
## データセットの作成
```console
bq --location=US mk -d \
  --default_table_expiration 3600 \
  --description "This is my dataset." \
  mydataset
```

## データセットのアクセス制御の更新
1. データセットのJSONを取得
```console
bq show --format=prettyjson mydataset > /tmp/mydataset.json
```

2. /tmp/mydataset.jsonを編集
```json
{
  "access": [
    {
      "role": "WRITER",
      "specialGroup": "projectWriters"
    },
    {
      "role": "OWNER",
      "specialGroup": "projectOwners"
    },
    {
      "role": "OWNER",
      "userByEmail": "hyakushoio@gmail.com"
    },
    {
      "role": "READER",
      "specialGroup": "projectReaders"
    }
  ],
```

3. 更新
```console
bq update --source /tmp/mydataset.json mydataset
```

4. 確認
```console
bq show --format=prettyjson mydataset
```

## データセットの一覧表示
```console
bq ls
```

## データセットに関する情報の取得
```console
bq show --format=prettyjson mydataset
```

## INFORMATION_SCHEMA
### SCHEMATAビュー
例1. すべてのdatasetを取得
```console
bq query --nouse_legacy_sql \
'SELECT
   * EXCEPT(schema_owner)
 FROM
   INFORMATION_SCHEMA.SCHEMATA'
```

### SCHEMATA_OPTIONSビュー
例1. すべてのdefault_table_expiration_daysを取得
```
bq query --nouse_legacy_sql \
'SELECT
   *
 FROM
   INFORMATION_SCHEMA.SCHEMATA_OPTIONS
 WHERE
   option_name="default_table_expiration_days"'
```

例2. すべてのlabelsを取得
```
bq query --nouse_legacy_sql \
'SELECT
   *
 FROM
   INFORMATION_SCHEMA.SCHEMATA_OPTIONS
 WHERE
   option_name="labels"'
```

## データセットのプロパティの更新
例1. デスクリプションの更新
```console
bq update --description "Description of mydataset" mydataset
```

例2. デフォルトのテーブル有効期限の更新
```console
bq update --default_table_expiration 7200 mydataset
```

例3. デフォルトのパーティションの有効怪訝の更新
```console
bq update --default_partition_expiration 93600 mydataset
```
