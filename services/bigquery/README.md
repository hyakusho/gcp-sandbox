# BigQuery

## クイックスタート
### bq
```
bq show [<project_id>:<dataset_id>.<table_id>]
bq help
bq help query
bq query --use_legacy_sql=false '...'
bq ls
bq mk <dataset_id>
bq load <dataseet_id>.<table_id> <upload_file> <schema>
bq rm -r <dataset_id>
```

### API
#### ruby
```
cd apis/ruby
bundle exec ruby stackoverflow.rb
```

## 入門ガイド
### bq
- 一般的な使用法
```
bq --global_flag argument bq_command --command-specific_flag argument
bq version
bq help             # すべてのコマンドの一覧
bq --help           # グローバルフラグの一覧
bq help <command>   # 特定のコマンドのヘルプ
bq command --help   # 特定のコマンドのヘルプとグローバルフラグの一覧
```

- デバッグ
```
--apilog=(<path/to/file>|-|stdout|stderr)
--format=prettyjson
```

- コマンドラインのデフォルト値の設定
```
export BIGQUERYRC=<path/to/.bigqueryrc>
```
