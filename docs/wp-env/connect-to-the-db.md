Get jq for reading .json
https://jqlang.github.io/jq/
brew install jq


docker inspect mysql-1 | jq '.[].NetworkSettings.Ports."3306/tcp"[].HostPort'