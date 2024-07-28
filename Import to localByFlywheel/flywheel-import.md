# Make a site in flywheel
Start a new site with nginx and php 7XXX
pull the plugins and themes into the project wp-content folder

# Optionally Redirect to production images
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

restart the site in LocalByFlywheel

# download the db
terminus wp unc-sites.live -- db export - --tables=$(terminus wp unc-sites.live -- db tables 'wpsites_1386_*' --url=cci.unc.edu --format=csv) > database.sql

# import the db
wp db import database.sql

# import the stored proceedure
wp db query < change-table-prefix.sql

# delete unused tables
in adminer select sql command `DROP TABLE IF EXISTS wp_commentmeta,wp_comments,wp_links,wp_options,wp_postmeta,wp_posts,wp_term_relationships,wp_term_taxonomy,wp_termmeta,wp_terms`

# change the table prefix
in adminer select sql command `CALL change_wp_tables_prefix("local","wpsites_1386_","wp_")`

# Search replce for the old db table names
wp search-replace wpsites_1386_ wp_ --report-changed-only

# Change the urls
wp search-replace cci.unc.edu cci.test --report-changed-only

# change the siteurl and home 
wp option update siteurl https://cci.test && wp option update home https://cci.test

