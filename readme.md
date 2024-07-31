# local development with WordPress and full site editing

This repo is the code materials for a workshop given at WPCampus 2024 at Georgetown University 

## Local by Flywheel

In many cases, local by flywheel is enough

```json
"settings": {
    "logViewer.watch": [
        {
            "title": "local php error logs",
            "pattern":"${workspaceFolder}/logs/php/error.log"

        }
    ]
}
```

## @wordpress\env

can be defined with a file named .wp-env.json in the root

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
```


