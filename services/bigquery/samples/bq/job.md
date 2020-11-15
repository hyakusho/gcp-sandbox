# job
## list
```console
bq ls -j
```

## show
```console
bq show -j $(bq ls -j -n 1 | tail -1 | awk '{print $1}')
```

# cancel
```console
bq cancel <job_id>
```
