output "instance_public_ip" {
  description = "Public IP address of the deployed compute instance"
  value       = oci_core_instance.web_app_server.public_ip
}

output "vcn_id" {
  description = "OCID of the Virtual Cloud Network"
  value       = oci_core_vcn.main_vcn.id
}

output "subnet_id" {
  description = "OCID of the Public Subnet"
  value       = oci_core_subnet.public_subnet.id
}
