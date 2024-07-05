# Proxmox VE Terraform Automations

## Introduction

This repository contains Terraform automations for Proxmox VE. The automations are designed to be used with the Proxmox VE API.

## Requirements

- Terraform
- Proxmox VE
- Make

### Required Files

- `lxc.auto.tfvars` - Contains the required variables for the Proxmox VE API
- SSH public key

## Usage

1. Clone the repository
2. Rename the `lxc.auto.tfvars.example` file to `lxc.auto.tfvars` and fill in the required variables.
3. Run `make help` to see the available commands.

Typically, the following commands are used:

- `make && make apply` - Plan and apply the Terraform automation

## License

This repository is licensed under the MIT license. See the [LICENSE](LICENSE) file for details.
