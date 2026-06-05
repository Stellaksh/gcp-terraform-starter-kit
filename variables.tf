variable "project_id" {
description = "GCP Project ID"
type = string
}

variable "region" {
description = "GCP Region"
type = string
default = "us-central1"
}

variable "environment" {
description = "Environment: dev, staging, prod"
type = string
default = "prod"
validation {
condition = contains(["dev","staging","prod"], var.environment)
error_message = "Must be dev, staging, or prod."
}
}

variable "gke_node_count" {
description = "GKE nodes per zone"
type = number
default = 2
}

variable "gke_machine_type" {
description = "GKE node machine type"
type = string
default = "n2-standard-2"
}

variable "db_tier" {
description = "Cloud SQL tier"
type = string
default = "db-custom-2-7680"
}
