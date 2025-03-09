# Path to the Google Cloud service account key file
variable "gcp_svc_key" {}

# Google Cloud project ID
variable "gcp_project" {}

# GCP region for resource deployment
variable "gcp_region" {}

# GCP zone for compute resources
variable "gcp_zone" {}

# Name of the Compute Engine instance
variable "machine_name" {}

# Machine type (CPU and RAM configuration)
variable "machine_type" {}

# Size of the OS disk (GB)
variable "osdisk_size" {}

# Size of the data disk (GB)
variable "datadisk_size" {}

# VPC network name
variable "compute_network" {}

# Subnet name
variable "subnet_network" {}

# Region for the subnet
variable "subnet_region" {}

# Username for SSH access
variable "user" {}

# Admin email for instance access
variable "email" {}


