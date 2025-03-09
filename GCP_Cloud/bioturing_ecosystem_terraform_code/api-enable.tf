#=======================================================
# Enable Compute Engine API (GCE)
#=======================================================
resource "google_project_service" "compute_api" { 
  project            = var.gcp_project
  service            = "compute.googleapis.com"
  disable_on_destroy = false  # Ensures API remains enabled after destroy
}

#=======================================================
# Enable Cloud Resource Manager API (For IAM & Policies)
#=======================================================
resource "google_project_service" "cloudresourcemanager_api" { 
  project            = var.gcp_project
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

#=======================================================
# Enable Network Services API (For Load Balancers)
#=======================================================
resource "google_project_service" "network_services_api" { 
  project            = var.gcp_project
  service            = "networkservices.googleapis.com"
  disable_on_destroy = false
}

#=======================================================
# Ensure APIs Are Enabled Before Terraform Proceeds
#=======================================================
resource "null_resource" "wait_for_api_activation" {
  provisioner "local-exec" {
    command = "sleep 60" # Waits 60 seconds to let APIs activate
  }

  depends_on = [
    google_project_service.compute_api,
    google_project_service.cloudresourcemanager_api,
    google_project_service.network_services_api
  ]
}
