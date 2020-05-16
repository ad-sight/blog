#!/bin/bash

# clean up
ls | grep -v generate.sh | xargs rm -rf

# Copy blog content
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links https://adsight.ca/blog/

# Copy 404 page
wget --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links --content-on-error --timestamping https://adsight.ca/blog/404.html

# Copy sitemaps
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links https://adsight.ca/blog/sitemap.xsl
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links https://adsight.ca/blog/sitemap.xml
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links https://adsight.ca/blog/sitemap-pages.xml
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links https://adsight.ca/blog/sitemap-posts.xml
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links https://adsight.ca/blog/sitemap-authors.xml
wget --recursive --no-host-directories --directory-prefix=. --adjust-extension --timeout=30 --no-parent --convert-links https://adsight.ca/blog/sitemap-tags.xml

# Replace localhost with domain
LC_ALL=C find . -type f -not -wholename *.git* -exec sed -i '' -e 's/http:\/\/adsight.ca/blog/https:\/\/adsight.ca\/blog/g' {} +
LC_ALL=C find . -type f -not -wholename *.git* -exec sed -i '' -e 's/adsight.ca/blog/adsight.ca\/blog/g' {} +
LC_ALL=C find . -type f -not -wholename *.git* -exec sed -i '' -e 's/http:\/\/www.gravatar.com/https:\/\/www.gravatar.com/g' {} +

# Set up Github Pages CNAME
