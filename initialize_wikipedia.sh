#!/bin/bash

set -e

DUMP_URL=https://dumps.wikimedia.org/enwiki/latest/enwiki-latest-pages-articles.xml.bz2
DUMP_FILE=/var/www/html/enwiki-latest-pages-articles.xml.bz2

if ! command -v wget &> /dev/null; then
  echo "Installing wget..."
  apt-get update && apt-get install -y wget
fi

if ! command -v bzip2 &> /dev/null; then
  echo "Installing bzip2..."
  apt-get install -y bzip2
fi

# Download the Wikipedia dump if it doesn't exist
if [ ! -f "$DUMP_FILE" ]; then
  echo "Downloading Wikipedia dump..."
  wget -O "$DUMP_FILE" "$DUMP_URL"
else
  echo "Wikipedia dump already exists."
fi

# Decompress the dump file
if [ ! -f "/var/www/html/enwiki-latest-pages-articles.xml" ]; then
  echo "Decompressing the dump file..."
  bzip2 -d "$DUMP_FILE"
else
  echo "Dump file already decompressed."
fi

# Import the dump file
echo "Importing the dump file..."
php /var/www/html/maintenance/importDump.php /var/www/html/enwiki-latest-pages-articles.xml

echo "Import completed."
