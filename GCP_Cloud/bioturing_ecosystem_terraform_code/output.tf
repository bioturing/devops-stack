# ================================================================
# Output Variables
# These outputs provide useful information after deployment.
# ================================================================

# Public IP address of the instance
output "public_ip" {
  description = "Public IP of the compute instance"
  value       = google_compute_address.static_ip.address
}

# Size of the attached data volume (disk)
output "data_volume" {
  description = "Size of the attached data volume (disk)"
  value       = google_compute_disk.datavol.size
}

# Region where the static IP is allocated
output "region" {
  description = "Region where the static IP is allocated"
  value       = google_compute_address.static_ip.region
}

# Default username for SSH access
output "username" {
  description = "Default username for instance access"
  value       = "bioturingadmin" # Hardcoded username - Ensure proper security measures
}

# Load Balancer External IP
output "load_balancer_ip" {
  description = "External IP of Load Balancer"
  value       = google_compute_global_address.lb_static_ip.address
}

# Load Balancer HTTPS URL (Using IP Address)
output "load_balancer_https_url" {
  description = "Access the application via HTTPS"
  value       = "https://${google_compute_global_address.lb_static_ip.address}"
}

# # SSL Certificate Expiry Date (For self-managed SSL only)
# output "ssl_certificate_expiry" {
#   description = "Expiry date of the SSL certificate"
#   value       = trimspace(shell("openssl x509 -enddate -noout -in ssl_cert/server.crt | cut -d= -f2"))
# }

# Health Check Status for Backend
output "backend_health_check_url" {
  description = "URL for checking backend instance health"
  value       = "http://${google_compute_global_address.lb_static_ip.address}:80/healthz"
}

# DNS Setup Instructions (For Future Use)
output "dns_setup_instructions" {
  description = "Instructions for setting up a domain name when ready"
  value       = <<EOT
  To configure a domain for this Load Balancer, follow these steps:

  1. Choose a domain name (e.g., example.com).
  2. Go to your domain registrar or Cloudflare and add the following DNS records:
  
     - A Record:
       Name: @
       Value: ${google_compute_global_address.lb_static_ip.address}
       TTL: 300
       Proxy Status: DNS Only (Gray Cloud)

     - CNAME Record (Optional for www subdomain):
       Name: www
       Value: [your-domain-here]
       TTL: 300
       Proxy Status: Proxied (Orange Cloud)

  3. Wait for DNS propagation (can take up to 24 hours).
  4. Access your site via https://[your-domain-here] once the SSL is set up.
EOT
}
