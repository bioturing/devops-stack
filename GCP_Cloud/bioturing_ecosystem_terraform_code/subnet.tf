# ====================================================================
# Subnet for Google Compute Instance
# ====================================================================
resource "google_compute_subnetwork" "bioturing-ecosystem-subnetwork" {
  name          = var.subnet_network
  ip_cidr_range = "192.168.10.0/24"
  region        = var.subnet_region
  network       = google_compute_network.bioturing-ecosystem-network.id

}