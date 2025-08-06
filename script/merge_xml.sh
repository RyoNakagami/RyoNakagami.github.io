#!/bib/bash

TARGET_FILE="_site/sitemap.xml"

external_urls=$(curl -s https://ryonakagami.github.io/regmonkey-datascience-blog/sitemap.xml \
      | awk '/<url>/,/<\/url>/' )

# Append the Jekyll-generated sitemap entries (if using jekyll-sitemap)
if [ -f sitemap-p.xml ]; then
  awk '/<url>/,/<\/url>/' sitemap-p.xml >> $TARGET_FILE
fi

# Remove closing </urlset>
sed -i '$d' $TARGET_FILE

# Append all external URLs
printf '%s\n' "$external_urls" >> $TARGET_FILE
echo '</urlset>' >> $TARGET_FILE

# Ensure well-formed XML using xmllint (optional, safe)
if command -v xmllint &> /dev/null; then
  echo "🔍 Checking sitemap format with xmllint"
  xmllint --noout $TARGET_FILE
else
  echo "⚠️ xmllint not found. Skipping XML validation."
fi
