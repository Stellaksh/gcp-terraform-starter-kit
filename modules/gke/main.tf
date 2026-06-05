resource "google_service_account" "gke_nodes" {
account_id = "${var.cluster_name}-nodes"
display_name = "GKE Node Service Account"
project = var.project_id
}

resource "google_container_cluster" "primary" {
name = var.cluster_name
project = var.project_id
location = var.region

remove_default_node_pool = true
initial_node_count = 1
network = var.network
subnetwork = var.subnetwork

private_cluster_config {
enable_private_nodes = true
enable_private_endpoint = false
master_ipv4_cidr_block = "172.16.0.0/28"
}

ip_allocation_policy {
cluster_secondary_range_name = "pods"
services_secondary_range_name = "services"
}

workload_identity_config {
workload_pool = "${var.project_id}.svc.id.goog"
}

release_channel {
channel = "REGULAR"
}
}

resource "google_container_node_pool" "primary_nodes" {
name = "${var.cluster_name}-node-pool"
project = var.project_id
location = var.region
cluster = google_container_cluster.primary.name
node_count = 2

autoscaling {
min_node_count = 2
max_node_count = 10
}

node_config {
machine_type = "n2-standard-2"
service_account = google_service_account.gke_nodes.email
oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

shielded_instance_config {
enable_secure_boot = true
}
}

management {
auto_repair = true
auto_upgrade = true
}
}

output "cluster_name" { value = google_container_cluster.primary.name }
output "cluster_endpoint" { value = google_container_cluster.primary.endpoint }
