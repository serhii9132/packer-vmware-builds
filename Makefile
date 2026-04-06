ARTIFACTS_DIR := artifacts
ENV_FILE := .env
LOG_DIR := logs
LOG_TIMESTAMP := $(shell date +"%Y-%m-%d_%H-%M-%S")

LOAD_ENV := set -a; [ -f $(ENV_FILE) ] && . ./$(ENV_FILE); set +a
SETUP_LOGS := mkdir -p $(LOG_DIR) && export PACKER_LOG=1

OS_TARGETS := debian ubuntu

.PHONY: all $(OS_TARGETS) clean

all: $(OS_TARGETS)

$(OS_TARGETS):
	@$(LOAD_ENV) && pcg --os $@
	@packer init $(ARTIFACTS_DIR)/$@/$@.pkr.hcl
	@$(SETUP_LOGS) && \
	export PACKER_LOG_PATH="$(LOG_DIR)/$@_$(LOG_TIMESTAMP).log" && \
	packer build $(ARTIFACTS_DIR)/$@/$@.pkr.hcl

clean:
	rm -rfv logs artifacts