#=======================================================
# 1. Upload Self-Managed SSL Certificate
#=======================================================
resource "google_compute_ssl_certificate" "lb_ssl_cert" {
  name = "lb-ssl-cert"

  private_key = file("ssl_cert/server.key")  # Path to private key
  certificate = file("ssl_cert/server.crt")  # Path to certificate
}

#=======================================================
# 2. Create a HTTPS Target Proxy
#=======================================================
resource "google_compute_target_https_proxy" "lb_https_proxy" {
  name             = "lb-https-proxy"
  url_map         = google_compute_url_map.lb_url_map.id
  ssl_certificates = [google_compute_ssl_certificate.lb_ssl_cert.id]
}

#=======================================================
# 3. Create HTTPS Forwarding Rule (Port 443)
#=======================================================
resource "google_compute_global_forwarding_rule" "lb_https_forwarding_rule" {
  name       = "lb-https-forwarding-rule"
  target     = google_compute_target_https_proxy.lb_https_proxy.id
  port_range = "443"
  ip_address = google_compute_global_address.lb_static_ip.address
}
