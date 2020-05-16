#!/bin/bash

# clean up
ls | grep -v generate.sh | xargs rm -rf

# Copy blog content
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links http://localhost:2368/

# Copy 404 page
wget --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links --content-on-error --timestamping http://localhost:2368/404.html

# Copy sitemaps
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links http://localhost:2368/sitemap.xsl
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links http://localhost:2368/sitemap.xml
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links http://localhost:2368/sitemap-pages.xml
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links http://localhost:2368/sitemap-posts.xml
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links http://localhost:2368/sitemap-authors.xml
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links http://localhost:2368/sitemap-tags.xml

# Replace localhost with domain
#LC_ALL=C find . -type f -not -wholename *.git* -exec sed -i '' -e 's/http:\/\/localhost:2368/https:\/\/adsight.ca\/blog/g' {} +
#LC_ALL=C find . -type f -not -wholename *.git* -exec sed -i '' -e 's/localhost:2368/adsight.ca\/blog/g' {} +
#LC_ALL=C find . -type f -not -wholename *.git* -exec sed -i '' -e 's/http:\/\/www.gravatar.com/https:\/\/www.gravatar.com/g' {} +

# Set up Github Pages CNAME
