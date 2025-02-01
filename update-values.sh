#!/bin/bash

set -x

# Set the repository URL
REPO_URL="https://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@github.com/harishc-biz/todo-app.git"
VALUES_FILE="helm_chart/todo-app/dev-values.yml"

  git config --global user.name "harishc-biz"

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

# Make changes to the Kubernetes manifest file(s)
# For example, let's say you want to change the image tag in a deployment.yaml file
sed -i "s/tag: .*/tag: $1/" $VALUES_FILE

# Add the modified files
git add .

# Commit the changes
git commit -m "Update Docker image tag to $1"

# Push the changes back to the repository
git push

# Cleanup: remove the temporary directory
rm -rf /tmp/temp_repo