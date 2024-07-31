# Using log viewer with VS code

1. You should have VS Code
2. Install [log viewer](https://marketplace.visualstudio.com/items?itemName=berublan.vscode-log-viewer) into VS code
3. Open up the wordpspace file and add the log viewer settings.  if this was a fresh workspace, I'd look like this

```json
{
	"folders": [
		{
			"path": "."
		}
	],
	"settings": {
		"logViewer.watch": [
			{
				"title": "local php error logs",
				"pattern":"${workspaceFolder}/logs/php/error.log"

			}
		]
	}
}

```
4. In app/public/index.php add `error_log('hello world)`
5. Click the Log Viewer Icon on theleft of VS Code
6. Click local php error logs
7. Reload Wordpress, you should see 'hello world' in the error logs
8. Anything more than a string will require `error_log(var_export( $objToLog, true))` where $objToLog is....