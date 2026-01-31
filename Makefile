ARTIFACTS_DIR := artifacts
ENV_FILE := .env
LOAD_ENV := set -a; [ -f $(ENV_FILE) ] && . ./$(ENV_FILE); set +a

LOG_DIR := logs
LOG_TIMESTAMP := $(shell date +"%Y-%m-%d_%H-%M-%S")
SETUP_LOGS = mkdir -p $(LOG_DIR) && export PACKER_LOG=1

debian:
	@$(LOAD_ENV) && pcg --os debian
	@packer init $(ARTIFACTS_DIR)/debian/debian.pkr.hcl
	@$(SETUP_LOGS) && \
	export PACKER_LOG_PATH="$(LOG_DIR)/debian_$(LOG_TIMESTAMP).log" && \
	packer build $(ARTIFACTS_DIR)/debian/debian.pkr.hcl

ubuntu:
	@$(LOAD_ENV) && pcg --os ubuntu
	@packer init $(ARTIFACTS_DIR)/ubuntu/ubuntu.pkr.hcl
	@$(SETUP_LOGS) && \
	export PACKER_LOG_PATH="$(LOG_DIR)/ubuntu_$(LOG_TIMESTAMP).log" && \
	packer build $(ARTIFACTS_DIR)/ubuntu/ubuntu.pkr.hcl