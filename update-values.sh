#!/bin/bash

# Path to the azure-pipelines-app.yml file
PIPELINE_FILE="/Users/harishac/Documents/Projects/Azure/ToDO-App/todo-app/azure-pipelines-app.yml"

# Path to the dev-values.yml file
VALUES_FILE="/Users/harishac/Documents/Projects/Azure/ToDO-App/todo-app/helm-chart/todo-app/dev-values.yml"

# Extract the build number from the arguments
BUILD_NUMBER=$1

if [ -z "$BUILD_NUMBER" ]; then
  echo "Build number not provided"
  exit 1
fi

# Update the Docker image tag number in the dev-values.yml file
sed -i '' "s/tag: .*/tag: $BUILD_NUMBER/" $VALUES_FILE

echo "Updated Docker image tag to $BUILD_NUMBER in $VALUES_FILE"

# Navigate to the repository directory
cd /Users/harishac/Documents/Projects/Azure/ToDO-App/todo-app

# Configure Git
git config --global user.email "your-email@example.com"
git config --global user.name "your-username"

# Add the changes to git
git add $VALUES_FILE

# Commit the changes
git commit -m "Update Docker image tag to $BUILD_NUMBER"

# Push the changes to the repository
git push origin main