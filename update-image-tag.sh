#!/bin/bash

# Check if the tag argument is provided
if [ -z "$1" ]; then
  echo "Error: Docker image tag not provided."
  echo "Usage: $0 <new-image-tag>"
  exit 1
fi

NEW_TAG=$1
VALUES_FILE="/helm_chart/todo-app/dev-values.yml"


# Check if the values.yaml file exists
if [ ! -f "$VALUES_FILE" ]; then
  echo "Error: $VALUES_FILE not found."
  exit 1
fi

# Update the image tag in values.yaml
sed -i "s/^\( *tag: *\).*/\1\"$NEW_TAG\"/" "$VALUES_FILE"

echo "Updated $VALUES_FILE with new image tag: $NEW_TAG"