# A local Docker setup

This is a local dev setup for using Docker.  It's for setting up single sites and multisite networks locally using docker.  

## Prerequisits
* Git
* Docker Desktop
* Composer
* NPM/Nodejs

## Get setup for your attack run
1. Double click the dev.local.code-workspace to open the workspace in vscode 
2. Open a terminal using Terminal > New Terminal
3. run the following, line-by-line in the director above this to get all the stuff

```bash
cd .. 
git clone https://github.com/hadamlenz/wordpress-and-nginx-for-docker.git
git clone https://github.com/hadamlenz/localhub.git 
git clone https://github.com/hadamlenz/wordpress-docker-image.git
```

all of those files should now be in the workspace

## Start up to test 
1. right click on the localhub folder and select "Open in integrated terminal"
2. run `docker compose up -d` this command will start the containers defined in docker-compose.yml.  You can install Docker for Visual Studio Code extension which allows you to right-click and Compose Up
3. you should low be able to go to [https://whoami.localhost/](https://whoami.localhost/) in chrome but you will get a cert warning. lets fix that

## Make a local CA and add some certs
1. right click the localhub/assets folder and select "Open in integrated terminal"
2. run `./make_ca` and follow the directions.  this should create myCA.key and myCA.pem
3. you now want to import myCA to your system.  this is different on different systems, [but delicious brains has a good guide on how to solve that](https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/#installing-root-cert).  this will make it so you only have to trust this cert
4. we want to make a cert for Permission denied and phpmyadmin.localhost so we'd run the following in the same folder
`./make_cert -u whoami.localhost`
`./make_cert -u phpmyadmin.localhost`
follow the directions, the FQDN is the url of the site
5. Back in localhub run `docker compose restart traefik`
6. The two entries for the above sites are already in `localhub/traefil/conf/traefik.toml` but any more certs need to be added here.  just copy the pattern of the first two

## Do you want to add test?
if you want to use the .localhost tld you will be always using chrome.  it's the only place where it works.  to use the .test tld you can do a couple things.
lets get whoami working on .test using [dnsmasq](dnsmasq.md).  this is untested on Windows and WSL

1. in the localhub find the line ```"traefik.http.routers.whoami.rule=Host(`whoami.localhost`)"``` and change whoami.localhost to whoami.test
2. in the assets folder run `./make_cert -u whoami.test` and add to `localhub/traefil/conf/traefik.toml`
3. follow the directions [here](docs/docker/dnsmasq.md) to get dnsmasq setup

## Get WordPress setup
1. Go to [phpmyadmin.localhost](https://phpmyadmin.localhost), you can log in with username: root and password: root
2. Create a database for your new Wordpress setup 
3. in wordpress-docker-image run `docker-compose build` to build the WordPress image.  this is a pretty simple Wordpress image with some built in extra stuff like Redis and wp-cli, ldap support and composer.  
4. After the image is built go into 
5. find the line like `"traefik.http.routers.sites_nginx.rule=Host`  and add the url you want to use for this site.  remeber to use the tld you picked in the section above
6. you can run the docker-compose.json in wordpress-and-nginx-for-docker

Still with me???