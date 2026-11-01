#!/usr/bin/env bash
# Builds the source bundle with Dockerfile at the ZIP root (Beanstalk requirement).
set -euo pipefail
cd "$(dirname "$0")/app"
rm -f ../app.zip
zip -r ../app.zip Dockerfile site
echo "Created $(cd .. && pwd)/app.zip"
