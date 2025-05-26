#!/bin/bash
sleep 10  # Wait for the service to start
set -e

URL="http://poc-http.labs.ayoba.me:8080"
LOG_FILE="log/health_check.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Create log file directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Send the request
HTTP_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

# Log the result
echo "$TIMESTAMP - Status Code: $HTTP_RESPONSE" >> "$LOG_FILE"

# Print and exit based on response
if [ "$HTTP_RESPONSE" -ne 200 ]; then
  echo "::warning ::Service not responding properly (Status: $HTTP_RESPONSE)"
  exit 1
else
  echo "::notice ::Service is healthy (Status: 200)"
fi
