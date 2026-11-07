# Compute Instance for Docker & App Hosting
resource "oci_core_instance" "web_app_server" {
  compartment_id      = var.compartment_ocid
  display_name        = "docker-production-host"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  shape               = "VM.Standard.E4.Flex"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }

  source_details {
    source_type = "image"
    source_id   = var.ubuntu_image_ocid
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public_subnet.id
    display_name     = "primary-vnic"
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = try(file(var.ssh_public_key_path), "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3dummydevopskeyforcloudinitdemo1234567890mohammedibrahim")
    user_data           = base64encode(<<-EOF
      #!/bin/bash
      apt-get update -y
      apt-get install -y ca-certificates curl gnupg lsb-release
      
      # Install Docker Engine & Compose
      curl -fsSL https://get.docker.com -o get-docker.sh
      sh get-docker.sh
      usermod -aG docker ubuntu
      
      # Verify Docker
      systemctl enable docker
      systemctl start docker
    EOF
    )
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}
