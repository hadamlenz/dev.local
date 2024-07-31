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