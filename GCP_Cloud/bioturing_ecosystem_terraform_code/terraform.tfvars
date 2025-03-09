# ----------------------------------------------------------
# GCP Project Configuration
# ----------------------------------------------------------

# Path to the service account key file (used for authentication).
gcp_svc_key = "./key/bioturing-ecosystem-temp_1hr_access.json" # Kindly replace with your key 

# Google Cloud Project ID (used for resource deployment).
gcp_project = "bioturing-ecosystem"  

# ----------------------------------------------------------
# Default Region and Zone
# ----------------------------------------------------------

# The default region where resources will be deployed.
gcp_region = "us-central1"

# The default zone within the selected region.
gcp_zone = "us-central1-a"

# ----------------------------------------------------------
# Compute Instance Configuration (Optional, Uncomment to Use)
# ----------------------------------------------------------

# Name of the Compute Engine instance.
machine_name = "bioturing-ecosystem-instance"

# Size of the OS disk in GB.
osdisk_size = 250

# Size of the data disk in GB.
datadisk_size = 1000

# Machine type (CPU, memory configuration).
machine_type = "a2-ultragpu-1g" # "e2-micro" 

# ----------------------------------------------------------
# Networking Configuration (Optional, Uncomment to Use)
# ----------------------------------------------------------

# Name of the VPC network for the instance.
compute_network = "bioturing-ecosystem-compute-network"

# Name of the subnet inside the network.
subnet_network = "bioturing-ecosystem-compute-subnetwork"

# Region where the subnet is located.
subnet_region = "us-central1"

# ----------------------------------------------------------
# User & SSH Key Configuration (Optional, Uncomment to Use)
# ----------------------------------------------------------

# Default username for VM access.
user = "bioturingadmin"  

# Email associated with the user.
email = "bioturingadmin@bioturing.com" 
