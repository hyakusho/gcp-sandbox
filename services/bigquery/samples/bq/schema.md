# テーブルスキーマ
## スキーマの指定
### 手動でのスキーマの指定
```console
bq load --source_format=CSV mydataset.mytable ./myfile.csv qtr:STRING,sales:FLOAT,year:STRING

# OR

bq mk --table mydataset.mytable qtr:STRING,sales:FLOAT,year:STRING
```

### JSONスキーマファイルの指定
```json
[
  {
    "description": "quarter",
    "mode": "REQUIRED",
    "name": "qtr",
    "type": "STRING"
  },
  {
    "description": "sales representative",
    "mode": "NULLABLE",
    "name": "rep",
    "type": "STRING"
  },
  {
    "description": "total sales",
    "mode": "NULLABLE",
    "name": "sales",
    "type": "FLOAT"
  }
]
```

```console
bq load --source_format=CSV mydataset.mytable ./myfile.csv ./myschema.json

# OR 

bq mk --table mydataset.mytable ./myschema.json
```

## ネストされた列と繰り返し列の指定
```json
[
    {
        "name": "id",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "first_name",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "last_name",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "dob",
        "type": "DATE",
        "mode": "NULLABLE"
    },
    {
        "name": "addresses",
        "type": "RECORD",
        "mode": "REPEATED",
        "fields": [
            {
                "name": "status",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "address",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "city",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "state",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "zip",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "numberOfYears",
                "type": "STRING",
                "mode": "NULLABLE"
            }
        ]
    }
]
```

## スキーマの自動検出
### 使用法
```console
bq --location=LOCATION load \
--autodetect \
--source_format=FORMAT \        # NEWLINE_DELIMITED_JSON or CSV
DATASET.TABLE \
PATH_TO_SOURCE
```

### サンプル
```console
bq load --autodetect --source_format=CSV mydataset.mytable ./myfile.csv
```
```console
bq load --autodetect --source_format=NEWLINE_DELIMITED_JSON mydataset.mytable ./myfile.json
```

## テーブルスキーマの変更
### 使用法
```console
bq update project_id:dataset.table schema
```

### 例1. テーブルのスキーマ定義荷からの列を追加する
1. 既存のテーブルスキーマをファイルに書き込む
```console
bq show --schema --format=prettyjson mydataset.mytable > /tmp/myschema.json
```

2. schemaファイルを編集する
```json
[
  {
    "mode": "REQUIRED",
    "name": "column1",
    "type": "STRING"
  },
  {
    "mode": "REQUIRED",
    "name": "column2",
    "type": "FLOAT"
  },
  {
    "mode": "REPEATED",
    "name": "column3",
    "type": "STRING"
  },
  # 以下の列を追加
  {
    "description": "my new column",
    "mode": "NULLABLE",
    "name": "column4",
    "type": "STRING"
  }
]
```

3. テーブルのスキーマを更新
```console
bq update mydataset.mytable /tmp/myschema.json
```

