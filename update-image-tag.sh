#!/bin/bash

# Check if the tag argument is provided
if [ -z "$1" ]; then
  echo "Error: Docker image tag not provided."
  echo "Usage: $0 <new-image-tag>"
  exit 1
fi

NEW_TAG=$1
CHART_DIR="helm_chart"
HELM_REPO_NAME="todo-app"
VALUES_FILE="$CHART_DIR/$HELM_REPO_NAME/dev-values.yml"
HELM_REPO_URL="https://github.com/harishc-biz/todo-app" # Replace with your Helm repo URL
HELM_CHART_VERSION="0.1.0" # Update this as needed

# Check if the values.yaml file exists
if [ ! -f "$VALUES_FILE" ]; then
  echo "Error: $VALUES_FILE not found."
  exit 1
fi

# Step 1: Update the image tag in values.yaml
sed -i "s/^\( *tag: *\).*/\1\"$NEW_TAG\"/" "$VALUES_FILE"

echo "Updated $VALUES_FILE with new image tag: $NEW_TAG"

# Step 2: Package the Helm chart
helm package "$CHART_DIR" --version "$HELM_CHART_VERSION"
PACKAGED_CHART=$(ls todo-app-chart-*.tgz)
echo "Packaged Helm chart: $PACKAGED_CHART"

# Step 3: Push the Helm chart to the Helm repository
helm repo add "$HELM_REPO_NAME" "$HELM_REPO_URL"
helm cm-push "$PACKAGED_CHART" "$HELM_REPO_NAME"

echo "Helm chart pushed to $HELM_REPO_NAME repository."