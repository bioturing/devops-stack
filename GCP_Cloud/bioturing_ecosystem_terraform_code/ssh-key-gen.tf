# ====================================================================
# TLS Provider Configuration
# This is required to generate SSH private keys securely.
# ====================================================================
provider "tls" {
  # No configuration is needed for the TLS provider.
}

# ====================================================================
# Generate an SSH Private Key
# This creates a 4096-bit RSA private key for authentication.
# ====================================================================
resource "tls_private_key" "ssh" {
  algorithm = "RSA"  # The cryptographic algorithm (RSA)
  rsa_bits  = 4096   # Key size in bits (Higher is more secure)
}

# ====================================================================
# Store the Generated Private Key Locally
# This writes the generated SSH key to a file named "google_compute_engine".
# ====================================================================
resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem  # Private key content
  filename        = "./key/google_compute_engine"        # Output file name
  file_permission = "0600"                               # Restricts file access for security (only owner can read/write)
}

# ====================================================================
# Store the Generated Public Key Locally
# This writes the generated SSH public key to a file for reference.
# ====================================================================
resource "local_file" "ssh_public_key" {
  content  = tls_private_key.ssh.public_key_openssh  # Public key content
  filename = "./key/google_compute_engine.pub"       # Output file name
}

# ====================================================================
# Notes:
# - The generated private key is securely stored with restricted permissions.
# - The public key can be used to authenticate SSH access to instances.
# - No manual key generation is required; Terraform handles everything.
# ====================================================================
