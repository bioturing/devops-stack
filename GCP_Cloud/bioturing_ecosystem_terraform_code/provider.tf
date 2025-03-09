# ---------------------------------
# Terraform Variables for GCP Setup
# ---------------------------------

# GCP provider configuration
provider "google" {
  # Path to the service account key file (JSON)
  credentials = file(var.gcp_svc_key)  

  # GCP project ID (set in variables.tf)
  project     = var.gcp_project  

  # Default region for resources
  region      = var.gcp_region  

  # Default zone for compute resources
  zone        = var.gcp_zone  
}
