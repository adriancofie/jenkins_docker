#!/bin/bash

# Check the HTTP status code for the application
test $(curl -Is localhost:9090 | head -n 1 | awk '{ print $2}') -eq 200

