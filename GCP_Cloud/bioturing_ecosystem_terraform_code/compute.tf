# ================================================================
# 1. Compute Instance Definition
# ================================================================
resource "google_compute_instance" "bioturing-ecosystem-instance" {
  name         = var.machine_name
  machine_type = var.machine_type
  zone         = var.gcp_zone

  tags = ["bioturing-ecosystem-server"]

  metadata = {
    ssh-keys = "${var.user}:${tls_private_key.ssh.public_key_openssh}"
  }

#=======================================================
# Boot Disk (OS Disk)
#=======================================================
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"  # OS Image
      type  = "pd-ssd"                           # Disk type: pd-standard /pd-balanced / pd-ssd / pd-extreme 
      size  = var.osdisk_size                    # OS Disk Size
    }
  }

#=======================================================
# Network Configuration
#=======================================================
  network_interface {
    network    = google_compute_network.bioturing-ecosystem-network.self_link
    subnetwork = google_compute_subnetwork.bioturing-ecosystem-subnetwork.self_link

    access_config {
      nat_ip = google_compute_address.static_ip.address  # Assigning Static IP
    }
  }

#=======================================================
# Attach Additional Data Disk
#=======================================================
  attached_disk {
    source      = google_compute_disk.datavol.id  # Attaching Persistent Disk
    device_name = "datadisk"
  }

  # Ensuring the disk is available before attachment
  depends_on = [
    google_compute_disk.datavol
  ]
}

#================================================================
# 2. Create an Instance Group for Load Balancing
#================================================================
resource "google_compute_instance_group" "bioturing_instance_group" {
  name = "bioturing-instance-group"
  zone = var.gcp_zone

  instances = [google_compute_instance.bioturing-ecosystem-instance.id]

  named_port {
    name = "http"
    port = 80
  }
}
