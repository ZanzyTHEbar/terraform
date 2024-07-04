# Makefile for a Terraform project

# Default target
all: init plan

# Initialize Terraform
init:
	terraform init

# Format Terraform files
fmt:
	terraform fmt

# Validate Terraform files
validate:
	terraform validate

# Plan Terraform deployment
plan:
	terraform plan -out ./plan.out

# Apply Terraform deployment
apply:
	terraform apply ./plan.out

# Destroy Terraform managed infrastructure
destroy:
	terraform destroy -auto-approve

# Output Terraform managed infrastructure
output:
	terraform output

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  all        Initialize, format, validate, plan, and apply Terraform"
	@echo "  init       Initialize Terraform"
	@echo "  fmt        Format Terraform files"
	@echo "  validate   Validate Terraform files"
	@echo "  plan       Plan Terraform deployment"
	@echo "  apply      Apply Terraform deployment"
	@echo "  destroy    Destroy Terraform managed infrastructure"
	@echo "  output     Output Terraform managed infrastructure"
	@echo "  help       Display this help message"

.PHONY: all init fmt validate plan apply destroy output