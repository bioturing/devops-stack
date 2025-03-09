# ====================================================================
# Subnet for Google Compute Instance
# ====================================================================
resource "google_compute_network" "bioturing-ecosystem-network" {
  name                    = var.compute_network
  auto_create_subnetworks = false
}

