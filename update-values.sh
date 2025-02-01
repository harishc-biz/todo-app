#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -x  # Print commands and their arguments as they are executed

# Set the repository URL with the PAT
REPO_URL="https://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@github.com/harishc-biz/todo-app.git"
VALUES_FILE="helm_chart/todo-app/dev-values.yml"

# Configure Git
git config --global user.name "harishc-biz"
git config --global user.email "harishdravid9845@gmail.com"

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

# Make changes to the Kubernetes manifest file(s)
# For example, let's say you want to change the image tag in a deployment.yaml file
sed -i "s/tag: .*/tag: $1/" $VALUES_FILE

# Add the modified files
git add $VALUES_FILE

# Commit the changes
git commit -m "Update Docker image tag to $1"

# Push the changes back to the repository
git push

# Cleanup: remove the temporary directory
rm -rf /tmp/temp_repo