#=======================================================
# Addional volume for User data
#=======================================================
resource "google_compute_disk" "datavol" {
  project = var.gcp_project     # GCP project ID where the disk will be created
  name    = "datavolume"        # Name of the persistent disk
  type    = "pd-balanced"       # Disk type: pd-standard /pd-balanced / pd-ssd / pd-extreme 
  zone    = var.gcp_zone        # Deployment zone
  size    = var.datadisk_size   # Size of the disk in GB

  labels = {
    environment = "bioturing-ecosystem"  # Labeling the disk for organization
  }

  lifecycle {
    prevent_destroy = false   # Prevents accidental deletion of the disk use true
  }
}
