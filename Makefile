ARTIFACTS_DIR := artifacts
ENV_FILE := .env

debian: $(ENV_FILE)
	@pcg --os debian
	@packer init $(ARTIFACTS_DIR)/debian/debian.pkr.hcl
	packer build $(ARTIFACTS_DIR)/debian/debian.pkr.hcl

ubuntu: $(ENV_FILE)
	@pcg --os ubuntu
	@packer init $(ARTIFACTS_DIR)/ubuntu/ubuntu.pkr.hcl
	packer build $(ARTIFACTS_DIR)/ubuntu/ubuntu.pkr.hcl

clean: $(VENV)
	rm -rf $(VENV)