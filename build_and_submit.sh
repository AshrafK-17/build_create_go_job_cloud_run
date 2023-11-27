#!/bin/bash

# Set your variables
PROJECT_ID="eco-spirit-404410"
REGION="us-central1"
REPO_NAME="build-test-script"
REPO_FORMAT="docker"
SOURCE_DIR="."
COMMIT_HASH=$(git rev-parse --short HEAD)
# TIMESTAMP=$(date +%Y%m%d%H%M%S)
VERSION="1.0"

echo ""
echo "-----------------------------------------------------------------------"
echo "Building Artifact Registry for Hello World version: $VERSION"
echo "-----------------------------------------------------------------------"
echo ""

echo "Enable gcloudignore"
gcloud config set gcloudignore/enabled true

# Create Artifact Registry repository
gcloud artifacts repositories create "${REPO_NAME}" \
    --repository-format="${REPO_FORMAT}" \
    --location="${REGION}" \

echo ""
echo "-----------------------------------------------------------------------"
echo "Building Docker image & Pushing to the Artifact Registry using Cloud Build and Pack"
echo "-----------------------------------------------------------------------"
echo ""

# Submit a build using Cloud Build and Pack
gcloud builds submit --pack image="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/helloworld:${COMMIT_HASH}" "${SOURCE_DIR}"
