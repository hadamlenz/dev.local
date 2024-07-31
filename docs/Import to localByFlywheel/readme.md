# Import a pantheon site into local by flywheel

0. if you have wp-migrate-db working you can export the site and esily [import it to flywheel](https://localwp.com/help-docs/getting-started/how-to-import-a-wordpress-site-into-local/)

1. Make a site in flywheel
Start a new site with nginx using the php version you are using on the site (7 or 8)
pull the plugins and themes into the project wp-content folder

2. Optionally Redirect to production images, if you dont want to do this, skip to 3
add uploads-proxy.conf to the site/conf/nginx folder changing the url to represent the remote site url and site id

in the project folder/conf/nginx/site.conf.hbs find 
```
#
# WordPress Rules
#
{{#unless site.multiSite}}
include includes/wordpress-single.conf;
{{else}}
include includes/wordpress-multi.conf;
{{/unless}}
```

and add the following under it
```
#
# Proxy requests to the upload directory to the production site
#
include uploads-proxy.conf;
```

change the variables in to match the remote site url.  This should point to the uploads folder of the remote site and allows you to not have to download all the of the files.  If you are not using multisite on the remote, you can delete `[MAYBEMULTISITEPATH]`
restart the site in LocalByFlywheel

3. download the db from a multisite on pantheon
`terminus wp [SITE].[ENV] -- db export - --tables=$(terminus wp [SITE].[ENV] -- db tables '[PREFIX]_*' --url=[SITEURL] --format=csv) > database.sql`

You can change that as needed for each host on Pantheon

If your host requires you to SSH to run wp-cli you can just run 
`wp db export - > database.sql`

you might want to do that in a folder other than root

and then download it with 
`scp username@hostname:/path/to/remote/file /path/to/local/file`

4. import the db
`wp db import database.sql`

5.  if you need to change the prefixes on the wableimport the stored proceedure
`wp db query < change-table-prefix.sql`

6. delete unused tables
in adminer select sql command `DROP TABLE IF EXISTS wp_commentmeta,wp_comments,wp_links,wp_options,wp_postmeta,wp_posts,wp_term_relationships,wp_term_taxonomy,wp_termmeta,wp_terms`

7. change the table prefix
in adminer select sql command `CALL change_wp_tables_prefix("local","[OLDPREFIX]_","wp_")`

8. Search replce for the old db table names.  if the user capabilities go wonky
`wp search-replace [OLDPREFIX]_ wp_ --report-changed-only`

9. Change the urls
`wp search-replace [SITEURL] [NEWLOCALSITEURL] --report-changed-only`

10. change the siteurl and home 
`wp option update siteurl [SCHEME][[NEWLOCALSITEURL] && wp option update home [SCHEME][[NEWLOCALSITEURL]`

