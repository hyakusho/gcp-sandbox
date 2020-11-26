# テーブルの操作
## テーブルの作成と使用
使用法
```console
bq mk \
--table \
--expiration integer \
--description description \
--label key:value, key:value \
project_id:dataset.table \
schema
```

サンプル
```console
bq mk \
-t \
--expiration 3600 \
--description "This is my table" \
--label organization:development \
mydataset.mytable \
qtr:STRING,sales:FLOAT,year:STRING    # OR path/to/json_schema
```

### クエリ結果からのテーブルの作成
使用法
```console
bq --location=location query \
--destination_table project_id:dataset.table \
--use_legacy_sql=false 'query'
```

サンプル
```console
bq query \
--destination_table mydataset.mytable \
--use_legacy_sql=false \
'SELECT
  name,
  number
FROM
  `bigquery-public-data`.usa_names.usa_1910_current
WHERE
  gender = "M"
ORDER BY
  number DESC'
```
