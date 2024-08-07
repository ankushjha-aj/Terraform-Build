# PLEASE READ README.md FILE FIRST BEFORE ACCESSING IT 

provider "google" {
  project = "steady-service-429006-t5"
  region  = "us-central1"
}

# Define VPC Network
resource "google_compute_network" "vpc_network" {
  name                    = "net-app-volume"
  auto_create_subnetworks = false
}

# Define Public Subnets
resource "google_compute_subnetwork" "public_subnet_1" {
  name          = "public-subnet-1"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "public_subnet_2" {
  name          = "public-subnet-2"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "public_subnet_3" {
  name          = "public-subnet-3"
  ip_cidr_range = "10.0.3.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

# Define Global Address for Private Service Access
resource "google_compute_global_address" "private_service_access_range" {
  provider      = google
  name          = "private-service-access-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

# Create Service Networking Connection
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = "netapp.servicenetworking.goog"
  reserved_peering_ranges = [google_compute_global_address.private_service_access_range.name]

  depends_on = [
    google_compute_network.vpc_network
  ]
}

# Creating the NetApp Storage Pool, depends on VPC network and service networking connection
resource "google_netapp_storage_pool" "storage_pool" {
  name          = "netapp-storage-pool"
  location      = "us-central1"
  network       = google_compute_network.vpc_network.id
  project       = "steady-service-429006-t5"
  capacity_gib  = 2048
  service_level = "STANDARD"

  depends_on = [
    google_compute_network.vpc_network,
    google_service_networking_connection.private_vpc_connection
  ]
}


# Creating the NetApp Volume, depends on the storage pool
resource "google_netapp_volume" "netapp_volume" {
  name         = "netapp-volume"
  location     = "us-central1"
  project      = "steady-service-429006-t5"
  storage_pool = google_netapp_storage_pool.storage_pool.name
  capacity_gib = 1024
  share_name   = "vol1"
  protocols    = ["NFSV3"]

  depends_on = [
    google_netapp_storage_pool.storage_pool
  ]
}

# Fetch Internal IPs of Instances
data "google_compute_instance" "instance_1_data" {
  name = google_compute_instance.instance_1.name
  zone = google_compute_instance.instance_1.zone
}

data "google_compute_instance" "instance_2_data" {
  name = google_compute_instance.instance_2.name
  zone = google_compute_instance.instance_2.zone
}

# Create GCP Instances
resource "google_compute_instance" "instance_1" {
  name         = "instance-1"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20240801"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.public_subnet_1.id

    access_config {
      // This block assigns a public IP to the instance
    }
  }
}

resource "google_compute_instance" "instance_2" {
  name         = "instance-2"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20240801"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.public_subnet_1.id

    access_config {
      // This block assigns a public IP to the instance
    }
  }
}

resource "google_compute_firewall" "nfs_egress" {
  name    = "nfs-egress-rule"
  network = google_compute_network.vpc_network.id

  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["2049", "111", "4045", "4046"]
  }

  allow {
    protocol = "udp"
    ports    = ["2049", "111", "4045", "4046"]
  }

  destination_ranges = ["${google_compute_global_address.private_service_access_range.address}/32"] # Update the actual range after the creating of this firewall rule that you will get in NET-APP volume Page, for e.g., 10.243.0.4/32 and then again run terraform apply to update the firewall rules

  source_ranges = [
    "${google_compute_instance.instance_1.network_interface[0].network_ip}/32",
    "${google_compute_instance.instance_2.network_interface[0].network_ip}/32"
  ]

  depends_on = [
    google_compute_network.vpc_network,
    google_compute_instance.instance_1,
    google_compute_instance.instance_2,
  ]

}

resource "google_compute_firewall" "allow_nfs_to_instances" {
  name    = "allow-nfs-to-instances"
  network = google_compute_network.vpc_network.id

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["2049", "111", "4045", "4046"]
  }

  allow {
    protocol = "udp"
    ports    = ["2049", "111", "4045", "4046"]
  }

  source_ranges = ["${google_compute_global_address.private_service_access_range.address}/32"] # Update the actual range after the creating of this firewall rule that you will get in NET-APP volume Page, for e.g., 10.243.0.4/32 and then again run terraform apply to update the firewall rules

  priority = 1000

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    google_compute_network.vpc_network,
    google_netapp_volume.netapp_volume,
    google_compute_instance.instance_1,
    google_compute_instance.instance_2,

  ]
}

# After the apply command runs successfully, and you will get your resources that you are willing to. You need to redirect to gcp console in your browser and go to net app volumes,
# And inside net app volume you will see an options name as Mount instructions You will get your net app range IP there,
# You need to update the range IP in the above firewall rules and then again run terraform apply,
# This will update the firewall rules and you will be able to mount the net app volume to your instances. 
# Please note that you need to update the range IP in the above firewall rules and then again run terraform apply to update the firewall rules. 
# Please note that you need to update the range IP in the above firewall rules,
# and then again run terraform apply to update the firewall rules.

# After you get your mount instructions, you can follow that documentation to instal your net app volume inside your VMs,
# If you face any issues while following the documentation and you are not able to mount your net app volume, please follow this command as given below:
# sudo mount -t nfs -o nolock,rw,hard,rsize=65536,wsize=65536,vers=3,tcp 10.52.0.4:/your=provided-code (in mopunt app instructions)
# nolock: Disables file locking (can help with potential access issues)

# We can also create a yaml file that will mount the instructions inside your vm But every time you will get mount instructions, you need to update it inside your run command.

