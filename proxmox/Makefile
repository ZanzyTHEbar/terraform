# Makefile for a Terraform project

RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)


# Default target
all: init plan

# Initialize Terraform
init:
	@cd $(RUN_ARGS) && terraform init

# Format Terraform files
fmt:
	@cd $(RUN_ARGS) && terraform fmt

# Validate Terraform files
validate:
	@cd $(RUN_ARGS) && terraform validate

# Plan Terraform deployment
plan:
	@cd $(RUN_ARGS) && terraform plan -out ./plan.out

# Apply Terraform deployment
apply:
	@cd $(RUN_ARGS) && terraform apply ./plan.out

# Destroy Terraform managed infrastructure
destroytf:
	@cd $(RUN_ARGS) && terraform destroy -auto-approve

remove:
	@cd ./destroy && terraform plan -out ./plan.out && terraform apply -auto-approve "./plan.out"

clean:
	@cd $(RUN_ARGS) && rm -f ./plan.out ./terraform.tfstate ./terraform.tfstate.backup

# Output Terraform managed infrastructure
output:
	@cd $(RUN_ARGS) && terraform output

getip:
	./lxc-base/scripts/get_ip.sh $(RUN_ARGS)

help:
	@echo "Usage: make [target] [dir]"
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
	@echo "  getip      Get IP address of a container - Usage: make getip <node/lcx/id> <host ip>"
	@echo "  help       Display this help message"

%:
	@:

.PHONY: all init fmt validate plan apply destroy output getip help clean remove destroytf %