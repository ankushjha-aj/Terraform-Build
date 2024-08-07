# Infrastructure as Code (IaC) Deployment of GCP Environment with NetApp Volumes using Terraform
This repository provides a comprehensive guide to automate the deployment and management of a Google Cloud Platform (GCP) environment that incorporates high-performance NetApp volumes. Leveraging Terraform's Infrastructure as Code (IaC) capabilities, this solution streamlines the provisioning process, ensuring consistency, scalability, and reproducibility.

# key Features 
- Seamless Infrastructure Provisioning: Easily create and configure essential GCP resources, including virtual machines (VMs), networks, storage buckets, and NetApp volumes.
- NetApp Integration: Leverage the power and performance of NetApp Cloud Volumes Service for your GCP workloads, ensuring data resilience and fast access.
- Terraform Automation: Define your infrastructure declaratively using Terraform configuration files, enabling efficient management and updates.
- Modularity and Reusability: The codebase is organized into modules, promoting reusability and maintainability across different projects.
- Detailed Documentation: This README provides step-by-step instructions, explanations, and best practices to guide you through the deployment process.

# Overview of Components
1. Provider Configuration
The provider configuration specifies the GCP project and region where the resources will be created. It is essential to ensure that the correct project ID and region are specified to avoid resource misplacement.

2. VPC Network
A Virtual Private Cloud (VPC) network provides an isolated network environment within GCP. The VPC network is configured with auto_create_subnetworks set to false to manually define subnets.

3. Public Subnets
Three public subnets are created within the VPC network. Each subnet is defined with its own IP CIDR range. The subnets facilitate the segmentation of the network into different address spaces.

4. Private Service Access
Private service access allows private connectivity between your VPC network and GCP services. A global address is reserved for the private service access range, and a service networking connection is created to enable the private connection. 

5. NetApp Storage Pool and Volume
A NetApp storage pool is created within the specified region and VPC network. This storage pool serves as the underlying storage for the NetApp volume. The NetApp volume is then created within this storage pool, with specific capacity and protocols (e.g., NFS).

6. Compute Instances
Two compute instances are created within the VPC network. These instances are assigned to one of the public subnets. Each instance is configured with a boot disk image and network interface.

7. Firewall Rule 1
Egress Rule for NFS
An egress firewall rule is created to allow outgoing NFS traffic from the compute instances to the NetApp volume. The rule specifies the allowed protocols and ports for NFS traffic.

8. Firewall Rule 2
Ingress Rule for NFS
An ingress firewall rule is created to allow incoming NFS traffic from the NetApp volume to the compute instances. This rule also specifies the allowed protocols and ports for NFS traffic.

## Prerequisites
- Google Cloud Platform (GCP) Account: You'll need an active GCP account with appropriate permissions to create and manage resources.
- Putty-keygen or any other keygen for adding ssh in VM instances
- Terraform Installation: Ensure you have Terraform installed on your local machine. Refer to the official Terraform documentation for installation instructions.
- GCP Project and Credentials: Set up your GCP credentials using one of the following methods:
- Application Default Credentials
- Service Account Key File
- Environment Variables

## STEPS:
1. Clone the repository to your local machine using the command `git clone https://github.com/ankushjha-aj/Terraform-CLOUD/tree/GCP 
2. Navigate to the cloned repository using the command `cd /path/to/cloned/repository`
3. Open PUTTYGEN App and Add Your Desired ssh-rsa key in metadata in both instance inside "main.tf" file so that you can have same username and SSH key for both instances. for e.g., 
- ![alt text](image-1.png)
4. Adding the parameters will help you add an SSH-RSA key in your instances with the username of your choice.
5. Update "main.tf" according to your naming conventions as this is a single file without modules it will be easier for making updation.
6. Initialize Terraform using the command `terraform init` 
7. Plan Terraform using the command  `terraform plan`
8. Apply Terraform using the command `terraform apply`
9. Once the deployment is complete, you can verify the resources created in the GCP console.
10. The Outputs of "main.tf" will give you outputs like 
- ![alt text](image-2.png)

- After the resources are created, go to the GCP Console.
- Navigate to NetApp > Volumes and find your volume.
- Follow the mount instructions to get the NetApp range IP.
- Edit the netapp-volume and `Add Rule` with instance Internal Ip tht you get after Creation of all your resources through terraform or you ca manually view your intstance internal IP like this, 
- ![alt text](image-3.png)
- Update the destination_ranges in the "nfs_egress firewall" rule and the source_ranges in the "allow_nfs_to_instances" firewall rule with the NetApp range IP in `main.tf` terraform script for e.g., add `10.243.0.4/32` in place of `${google_compute_global_address.private_service_access_range.address}/32"`
- ![alt text](image.png)

11. After updating the "main.tf" file, re-run the `terraform apply` command to update

# Update Firewall Rules:

1. After the resources are created, go to the GCP Console.
2. Navigate to NetApp > Volumes and find your volume.
3. Follow the mount instructions to get the NetApp range IP.
4. Update the destination_ranges in the nfs_egress firewall rule and the source_ranges in the allow_nfs_to_instances firewall rule with the NetApp range IP.
5. Run terraform apply again to update the firewall rules.
6. Update the actual range after the creating of this firewall rule that you will get in NET-APP volume Page, for e.g., 10.243.0.4/32 and then again run terraform apply to update the firewall rules 
![alt text](image.png) 
7. terraform apply (run again to update the firewall rule).

# Detailed Steps:
- In the GCP Console, go to NetApp > Volumes.
- Locate your volume and view the mount instructions to obtain the NetApp range IP.
- Update the Terraform configuration with the obtained NetApp range IP:
- Modify the destination_ranges in the nfs_egress firewall rule.
- Modify the source_ranges in the allow_nfs_to_instances firewall rule.
- Save the changes to your Terraform files.

# Mounting NetApp Volume

- Follow the instructions in the GCP Console to mount the NetApp volume to your instances.
- Make sure to update the firewall rules as mentioned above.
- You can use the following command to mount the NetApp volume to your instance:
- sudo mount -t nfs4 <NetApp_IP>:<volume_name> <mount_point> or sudo mount -t nfs -o nolock,rw,hard,rsize=65536,wsize=65536,vers=3,tcp <NetApp-IP>:/<share-name> /mnt
- Replace <NetApp_IP> with the IP of your NetApp volume, <volume_name> with the name of your NetApp volume, and <mount_point> with the desired mount point on your instance.

# How To Update (.github/workflows/netApp_volume.yml)
- Add Secrets in Github Rep Secrets:
- GCP_VM_HOST_1 (Public_IP)
- GCP_VM_USERNAME_1 (such as ubuntu or any other of your choice)
- GCP_VM_PRIVATE_KEY_1 (For Access "BEGIN WITH ......")

- If you have two VMs then add same secrets with Different name for another VM
- GCP_VM_HOST_2 (Public_IP)
- GCP_VM_USERNAME_2 (such as ubuntu or any other of your choice)
- GCP_VM_PRIVATE_KEY_2 (For Access "BEGIN WITH ......")

- You can use Same key and same username for Both Instance as well.
- You can also perform manual steps After making a connection SSH into your created VMs (Make Sure You allowed Port 22 For SSH Connection)

# Summary
- This README.md file includes detailed steps for setting up the infrastructure, explanations of each resource, and instructions for updating and using the created resources. By following these steps, you will be able to successfully deploy and manage a GCP environment with NetApp volumes using Terraform and GitHub Actions.

# Additional Notes
- Version Control: Use Git or a similar system to track changes to your Terraform code.
- State Management: Consider using remote state storage (e.g., in a GCP bucket) for better collaboration and state management. (for storing tfstate files) 
- Security Best Practices: Apply appropriate security measures to your GCP resources and NetApp volumes.


 