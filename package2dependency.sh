#!/bin/bash

# Read the JSON file
json=$(cat package.json)

# Extract the "dependencies" field and save it to a new JSON file
echo "$json" | jq '{ dependencies }' > dependencies.json