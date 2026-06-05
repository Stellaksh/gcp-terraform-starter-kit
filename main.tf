terraform {
required_version = ">= 1.5.0"
required_providers {
google = {
source = "hashicorp/google"
version = "~> 5.0"
}
}
}

provider "google" {
project = var.project_id
region = var.region
}

module "vpc" {
source = "./modules/vpc"
project_id = var.project_id
region = var.region
network_name = "${var.environment}-vpc"
}

module "gke" {
source = "./modules/gke"
project_id = var.project_id
region = var.region
cluster_name = "${var.environment}-gke"
network = module.vpc.network_name
subnetwork = module.vpc.subnet_name
environment = var.environment
}

module "cloudsql" {
source = "./modules/cloudsql"
project_id = var.project_id
region = var.region
db_name = "${var.environment}-postgres"
network_id = module.vpc.network_id
environment = var.environment
}

module "storage" {
source = "./modules/storage"
project_id = var.project_id
region = var.region
bucket_name = "${var.project_id}-${var.environment}-assets"
}

module "iam" {
source = "./modules/iam"
project_id = var.project_id
}

