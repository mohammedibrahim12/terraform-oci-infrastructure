# Virtual Cloud Network (VCN)
resource "oci_core_vcn" "main_vcn" {
  compartment_id = var.compartment_ocid
  display_name   = "production-devops-vcn"
  cidr_blocks    = ["10.0.0.0/16"]
  dns_label      = "devopsvcn"
}

# Internet Gateway for public ingress/egress
resource "oci_core_internet_gateway" "main_igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "production-igw"
  enabled        = true
}

# Public Route Table
resource "oci_core_route_table" "public_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "public-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.main_igw.id
  }
}

# Public Security List (Firewall Rules)
resource "oci_core_security_list" "public_sl" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "public-security-list"

  # Ingress: Allow SSH (Port 22)
  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 22
      max = 22
    }
  }

  # Ingress: Allow HTTP (Port 80)
  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 80
      max = 80
    }
  }

  # Ingress: Allow HTTPS (Port 443)
  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 443
      max = 443
    }
  }

  # Egress: Allow all outbound traffic
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

# Public Subnet
resource "oci_core_subnet" "public_subnet" {
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.main_vcn.id
  display_name        = "public-web-subnet"
  cidr_block          = "10.0.1.0/24"
  dns_label           = "websubnet"
  route_table_id      = oci_core_route_table.public_rt.id
  security_list_ids   = [oci_core_security_list.public_sl.id]
}
