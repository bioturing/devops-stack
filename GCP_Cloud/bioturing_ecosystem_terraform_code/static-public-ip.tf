# ====================================================================
# Create a Static Public IP Address for Google Compute Instance
# This IP will be used to access the VM externally.
# ====================================================================
resource "google_compute_address" "static_ip" {
  name       = "bioturing-ecosystem-public-address"   # Descriptive name for easy identification
  project    = var.gcp_project                        # Google Cloud project ID
  region     = var.gcp_region                         # The region where the IP will be created
  
  # Ensure this resource is created after the firewall rules are applied.
  depends_on = [google_compute_firewall.bioturing-ecosystem-access]
}
