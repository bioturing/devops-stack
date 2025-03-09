#=======================================================
# 1. Create a Static IP for Load Balancer
#=======================================================
resource "google_compute_global_address" "lb_static_ip" {
  name = "lb-static-ip"
}

#=======================================================
# 2. Create a Health Check for Load Balancer
#=======================================================
resource "google_compute_health_check" "lb_health_check" {
  name               = "http-health-check"
  timeout_sec        = 5
  check_interval_sec = 5

  http_health_check {
    port = "80"
  }
}

#=======================================================
# 3. Create a Backend Service (Attach Instance Group)
#=======================================================
resource "google_compute_backend_service" "lb_backend_service" {
  name                    = "lb-backend-service"
  load_balancing_scheme   = "EXTERNAL"
  protocol                = "HTTP"
  port_name               = "http"
  timeout_sec             = 10

  backend {
    group = google_compute_instance_group.bioturing_instance_group.id
  }

  health_checks = [google_compute_health_check.lb_health_check.id]
}

#=======================================================
# 4. Create URL Map (Routes Traffic)
#=======================================================
resource "google_compute_url_map" "lb_url_map" {
  name            = "lb-url-map"
  default_service = google_compute_backend_service.lb_backend_service.id
}

#=======================================================
# 5. Create Target HTTP Proxy
#=======================================================
resource "google_compute_target_http_proxy" "lb_http_proxy" {
  name    = "lb-http-proxy"
  url_map = google_compute_url_map.lb_url_map.id
}

#=======================================================
# 6. Create Global Forwarding Rule (Routes HTTP Traffic)
#=======================================================
resource "google_compute_global_forwarding_rule" "lb_http_forwarding_rule" {
  name       = "lb-http-forwarding-rule"
  target     = google_compute_target_http_proxy.lb_http_proxy.id
  port_range = "80"
  ip_address = google_compute_global_address.lb_static_ip.address
}
