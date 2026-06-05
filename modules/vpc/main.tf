resource "google_compute_network" "vpc" {
name = var.network_name
project = var.project_id
auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
name = "${var.network_name}-subnet"
project = var.project_id
region = var.region
network = google_compute_network.vpc.id
ip_cidr_range = "10.0.0.0/20"

secondary_ip_range {
range_name = "pods"
ip_cidr_range = "10.1.0.0/16"
}

secondary_ip_range {
range_name = "services"
ip_cidr_range = "10.2.0.0/20"
}

private_ip_google_access = true
}

resource "google_compute_router" "router" {
name = "${var.network_name}-router"
project = var.project_id
region = var.region
network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat" {
name = "${var.network_name}-nat"
project = var.project_id
router = google_compute_router.router.name
region = var.region
nat_ip_allocate_option = "AUTO_ONLY"
source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

output "network_name" { value = google_compute_network.vpc.name }
output "network_id" { value = google_compute_network.vpc.id }
output "subnet_name" { value = google_compute_subnetwork.subnet.name }
