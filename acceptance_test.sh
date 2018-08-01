#!/bin/bash

# Check the HTTP status code for the application
echo "Checking status codes"

test $(curl -LI localhost:80 -o /dev/null -w '%{http_code}\n' -s) -eq 200

echo $?



