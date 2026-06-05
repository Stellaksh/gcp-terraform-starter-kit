GCP Production Infrastructure — Terraform Starter Kit 
Built and maintained by Stellaksh Digital — Elite Cloud & DevOps Teams for Global Tech Companies 
Overview 
Production-grade Google Cloud Platform infrastructure provisioned entirely with Terraform. This starter kit provisions a complete, security-hardened GCP environment suitable for SaaS applications at scale. 
Architecture 
┌─────────────────────────────────────────────────────┐ 
│ GCP Project │ 
│ │ 
│ ┌──────────────────────────────────────────────┐ │ 
│ │ Custom VPC │ │ 
│ │ │ │ 
│ │ ┌─────────────┐ ┌─────────────────────┐ │ │ 
│ │ │ GKE Cluster │ │ Cloud SQL (PG) │ │ │ 
│ │ │ (Private) │ │ (Private IP) │ │ │ 
│ │ └─────────────┘ └─────────────────────┘ │ │ 
│ │ │ │ 
│ │ ┌─────────────┐ ┌─────────────────────┐ │ │ 
│ │ │ Cloud Run │ │ Cloud Storage │ │ │ 
│ │ │ Services │ │ (Versioned) │ │ │ 
│ │ └─────────────┘ └─────────────────────┘ │ │ 
│ └──────────────────────────────────────────────┘ │ 
│ │ 
│ IAM · Cloud Armor · VPC Service Controls │ 
└─────────────────────────────────────────────────────┘ 
What Gets Provisioned
Resource 
Purpose







Custom VPC 
Isolated network with private subnets
GKE Cluster (Private) 
Kubernetes cluster with private nodes
Cloud SQL (PostgreSQL) 
Managed database with private IP only
Cloud Storage Bucket 
Object storage with versioning enabled
Service Accounts 
Least-privilege IAM for each workload
Cloud NAT 
Outbound internet for private nodes
Firewall Rules 
Secure ingress/egress rules



Prerequisites 
Terraform >= 1.5.0 
GCP Project with billing enabled 
gcloud CLI authenticated 
Required APIs enabled (script provided) 
Quick Start 
# 1. Clone the repository 
git clone https://github.com/stellaksh-digital/gcp-terraform-starter-kit cd gcp-terraform-starter-kit 
# 2. Enable required GCP APIs 
chmod +x scripts/enable-apis.sh 
./scripts/enable-apis.sh 
# 3. Configure your variables 
cp terraform.tfvars.example terraform.tfvars 
# Edit terraform.tfvars with your project values 
# 4. Initialize Terraform 
terraform init 
# 5. Plan the deployment 
terraform plan 
# 6. Apply
terraform apply 
Project Structure 
gcp-terraform-starter-kit/ 
├── main.tf # Root module — calls all submodules 
├── variables.tf # Input variable definitions 
├── outputs.tf # Output values 
├── versions.tf # Provider and Terraform version locks ├── terraform.tfvars.example 
├── modules/ 
│ ├── vpc/ # VPC, subnets, firewall rules 
│ ├── gke/ # GKE cluster and node pools 
│ ├── cloudsql/ # Cloud SQL instance and databases 
│ ├── storage/ # Cloud Storage buckets 
│ └── iam/ # Service accounts and IAM bindings 
└── scripts/ 
 └── enable-apis.sh # Enable required GCP APIs 
Security Posture 
GKE nodes are private — no public IPs on nodes 
Cloud SQL accessible via private IP only 
Service accounts follow least-privilege principle 
All storage buckets have versioning and uniform bucket-level access Firewall rules default deny all, explicit allow only 
Cost Estimate
Resource 
Estimated Monthly Cost
GKE Cluster (n2-standard-2 x2) 
~$120
Cloud SQL (db-f1-micro) 
~$25
Cloud Storage (100GB) 
~$2
Cloud NAT 
~$5
Total 
~$152/month










Costs vary by region and usage. Use terraform plan to see exact resource counts. 
Built By 
Stellaksh Digital — Bengaluru, India 
Website: stellaksh.com 
Upwork: upwork.com/freelancers/stellaksh 
Specialization: GCP Architecture · Kubernetes · DevOps · Terraform 
Need this infrastructure deployed for your project? Contact Stellaksh Digital
