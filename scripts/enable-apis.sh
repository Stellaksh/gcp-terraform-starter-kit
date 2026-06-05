#!/bin/bash
# Stellaksh Digital — Enable required GCP APIs
# Run once before terraform init
PROJECT_ID=${1:-$(gcloud config get-value project)}
echo "Enabling required APIs for project: $PROJECT_ID"
apis=(
"compute.googleapis.com"
"container.googleapis.com"
"sqladmin.googleapis.com"
"storage.googleapis.com"
"iam.googleapis.com"
"cloudresourcemanager.googleapis.com"
"servicenetworking.googleapis.com"
"logging.googleapis.com"
"monitoring.googleapis.com"
)
for api in "${apis[@]}"; do
echo "Enabling $api..."
gcloud services enable "$api" --project="$PROJECT_ID"
done
echo "All APIs enabled successfully."
