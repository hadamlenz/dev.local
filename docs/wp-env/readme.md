## @wordpress\env

Efectvly a docker compose.  More [here](https://developer.wordpress.org/block-editor/reference-guides/packages/packages-env/)  

I highly suggest you run `npm -g i @wordpress/env`  so that you dont have to run npm run on every command.  

It can be defined with a file named .wp-env.json in the root, this is an example of the one we use.  For this to work you will need your theme in the themes folder, and have some plugins in the plugins folder.  Those are what I've mapped in the plugins attribute below

The env attribute sets custom ports, this allows me to run more that one wp-env at a time

```json
{
	"core": "WordPress/WordPress#6.6.1",
	"phpVersion": "8.3",
	"themes": ["."],
	"mappings": { ".htaccess": "./assets/wp-env/.htaccess", "wp-content/plugins/": "../../plugins/" },
	"lifecycleScripts": { "afterStart": "wp-env run cli wp theme activate unc-wilson" },
	"plugins": ["../../plugins/unc-content-elements", "../../plugins/unc-utility-bar", "../../plugins/unc-custom-css"],
	"env": {
		"development": {
			"port": 8881,
			"mysqlPort": 51600
		},
		"tests":{
			"port": 8882,
            "mysqlPort": 51601
		}
	}
}


Here is an example of an htacess that will use the uploads folder from a remote site 

```
# BEGIN Reverse proxy
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^wp-content\/uploads\/(.*)$ https:\/\/remote.site.domain\/wp-content\/$1 [R=302,L,NC]
# END Reverse proxy


# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>
# END WordPress
```

I've started building more into a [2024 fork here](https://github.com/hadamlenz/twentytwentyfour-env).