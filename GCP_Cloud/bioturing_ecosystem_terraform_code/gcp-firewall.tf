# ================================================================
# Security Note:
# - Allowing all IPs (0.0.0.0/0) is NOT recommended for production.
# - Restrict access based on your organization's requirements.
# - Use specific IP ranges instead of open access.
# ================================================================

# Request your public IP (Uncomment if you want to restrict SSH to your IP)
# --------------------------------------------------------------------------
/* data "http" "myip" {
  url = "https://api.ipify.org/"
} */

#=======================================================
# Firewall rule to allow HTTP/HTTPS and ICMP access
#=======================================================
resource "google_compute_firewall" "bioturing-ecosystem-access" {
  name          = "bioturing-ecosystem-firewall"                             # Firewall rule name
  network       = google_compute_network.bioturing-ecosystem-network.name
  source_ranges = ["0.0.0.0/0"]                                              # Open to all - restrict in production. 
                                                                             # Replace with your allowed network

  allow {
    protocol = "icmp"  # Allow ICMP (ping)
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]                                  # Allow HTTP, HTTPS, and additional ports
  }

  source_tags = ["bioturing-ecosystemserver"]                                # Firewall applies to instances with this tag
}

#=======================================================
# Firewall rule to allow SSH access (Port 22)
#=======================================================
resource "google_compute_firewall" "bioturing-ecosystem-access-ssh-22" {
  name    = "bioturing-ecosystem-firewall-22"                               # Firewall rule name for SSH
  network = google_compute_network.bioturing-ecosystem-network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]                                                       # Allow SSH access
  }

  ### Uncomment the following line to restrict SSH to your own IP
  ### source_ranges = ["${data.http.myip.response_body}/32"]

  source_ranges = ["0.0.0.0/0"]                                            # Open to all - NOT recommended for security. 
                                                                           # Replace with your allowed network
  source_tags   = ["bioturing-ecosystemserver"]                            # Apply firewall only to instances with this tag
}
