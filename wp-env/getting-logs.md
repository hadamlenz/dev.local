# Getting logs from @wordpress\env

This will get the logs, all of the logs
```bash
npm run wp-env logs --watch'
```

If you just want to get the logs that have `[php` in them you can grep
```bash
npm run wp-env logs --watch | grep -E '\[php'
```

Im sure there is a better way of doing this