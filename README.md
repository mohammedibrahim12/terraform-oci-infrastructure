# OCI Cloud Infrastructure as Code (Terraform)

Automated provisioning of production-ready Virtual Cloud Network (VCN), security firewalls, subnets, and Docker host compute instances on Oracle Cloud Infrastructure (OCI).

## Architecture Components
- **VCN & Networking:** Isolated CIDR block `10.0.0.0/16` with Internet Gateway and public Route Tables.
- **Security List:** Stateful firewall rules governing SSH (22), HTTP (80), and HTTPS (443) ingress.
- **Compute Instance:** `VM.Standard.E4.Flex` running Ubuntu with automated Cloud-Init bootstrapping Docker Engine and Docker Compose.
- **Automation Pipeline:** Modular Terraform code ready for integration with OCI Resource Manager and GitHub Actions.

## Quickstart
```bash
terraform init
terraform plan
terraform apply -auto-approve
```
