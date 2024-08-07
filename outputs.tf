# Outputs
output "network_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc_network.name
}

output "subnet_1_name" {
  description = "The name of the public subnet"
  value       = google_compute_subnetwork.public_subnet_1.name
}

output "subnet_2_name" {
  description = "The name of the public subnet"
  value       = google_compute_subnetwork.public_subnet_2.name
}

output "subnet_3_name" {
  description = "The name of the public subnet"
  value       = google_compute_subnetwork.public_subnet_3.name
}

output "private_service_access_range" {
  description = "The range of private service access"
  value       = google_compute_global_address.private_service_access_range.address
}

output "storage_pool" {
  description = "The name of the storage pool"
  value       = google_netapp_storage_pool.storage_pool.name
}

output "net_app_volume" {
  description = "The name of the NetApp Volume"
  value       = google_netapp_volume.netapp_volume.name
}

output "instance_1_internal_ip" {
  description = "The internal IP address of the instance"
  value       = google_compute_instance.instance_1.network_interface[0].network_ip
}

output "instance_2_internal_ip" {
  description = "The internal IP address of the instance"
  value       = google_compute_instance.instance_2.network_interface[0].network_ip

}

