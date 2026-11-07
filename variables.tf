variable "tenancy_ocid" {
  description = "OCI Tenancy OCID"
  type        = string
  default     = "ocid1.tenancy.oc1..example"
}

variable "user_ocid" {
  description = "OCI User OCID"
  type        = string
  default     = "ocid1.user.oc1..example"
}

variable "fingerprint" {
  description = "OCI API Key Fingerprint"
  type        = string
  default     = "20:3b:97:13:55:1c:5b:0d:d3:37:d8:50:4e:c5:42:ff"
}

variable "private_key_path" {
  description = "Path to OCI API Private Key"
  type        = string
  default     = "~/.oci/oci_api_key.pem"
}

variable "region" {
  description = "OCI Target Region"
  type        = string
  default     = "ap-mumbai-1"
}

variable "compartment_ocid" {
  description = "OCI Compartment OCID"
  type        = string
  default     = "ocid1.compartment.oc1..example"
}

variable "ubuntu_image_ocid" {
  description = "OCID of Ubuntu Minimal/Server Image"
  type        = string
  default     = "ocid1.image.oc1.ap-mumbai-1.example"
}

variable "ssh_public_key_path" {
  description = "Path to public SSH key for instance login"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
