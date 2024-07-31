# Get the port number of mysql after the container is started

Get jq for reading .json
https://jqlang.github.io/jq/

`brew install jq`

`run docker ps` and get the container ID

docker inspect [container ID] | jq '.[].NetworkSettings.Ports."3306/tcp"[].HostPort'