#!/bin/bash

# Define urls and https
from_url=http://localhost:2368
to_url=adsight.ca/blog
to_https=true

# clean up
rm -rf static
ls | grep -v generate.sh | grep -v gaCode | xargs rm -rf

# Copy blog content
wget --recursive --page-requisites --no-host-directories --directory-prefix=static --adjust-extension --timeout=30 --no-parent --convert-links ${from_url}/

# Copy 404 page
wget --no-host-directories --page-requisites --directory-prefix=static --adjust-extension --timeout=30 --no-parent --convert-links --content-on-error --timestamping ${from_url}/404.html

# Copy sitemaps
wget --recursive --no-host-directories --directory-prefix=static --adjust-extension --timeout=30 --no-parent --convert-links ${from_url}/sitemap.xsl
wget --recursive --no-host-directories --directory-prefix=static --adjust-extension --timeout=30 --no-parent --convert-links ${from_url}/sitemap.xml
wget --recursive --no-host-directories --directory-prefix=static --adjust-extension --timeout=30 --no-parent --convert-links ${from_url}/sitemap-pages.xml
wget --recursive --no-host-directories --directory-prefix=static --adjust-extension --timeout=30 --no-parent --convert-links ${from_url}/sitemap-posts.xml
wget --recursive --no-host-directories --directory-prefix=static --adjust-extension --timeout=30 --no-parent --convert-links ${from_url}/sitemap-authors.xml
wget --recursive --no-host-directories --directory-prefix=static --adjust-extension --timeout=30 --no-parent --convert-links ${from_url}/sitemap-tags.xml

# Replace localhost with real domain
if [ "${to_https}" == true ];
then LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,http://${from_url},https://${to_url},g" {} +;
fi
if [ "${to_https}" == false ];
then LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,http://${from_url},http://${to_url},g" {} +;
fi
LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,${from_url},${to_url},g" {} +
LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e 's,http://www.gravatar.com,https://www.gravatar.com,g' {} +


# Fix file extension issues
LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,.pngng,.png,g" {} +
LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,.pngpng,.png,g" {} +
LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,.jpgjpg,.jpg,g" {} +
LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,.jpjpg,.jpg,g" {} +
LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,.jpgpg,.jpg,g" {} +

LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,=\"\/content,=\"content,g" {} +


LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,Ghost,adsight,g" {} +
LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,ghost.org,adsight.ca,g" {} +


LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,Published with,,g" {} +

# compensate for some crawling bug that does not download w300
LC_ALL=C find ./static -type f -not -wholename *.git* -exec sed -i '' -e "s,size\/w300,size\/w600,g" {} +





# Set up Github Pages CNAME
# echo "${to_url}" > static/CNAME

cp -R ./static/* ./
rm -rf static

#sed  "/<\/body>/i\\
#$(cat gaCode)" index.html  > index.html

