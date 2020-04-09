BUILDER_NAME=ansible-playbook
IMAGE_NAME=atsuio/ansible-playbook
TEMPLATE_DIR=../build-templates

test: build
	@echo =============Test Run Starting=============
	docker run --rm -e "ANSIBLE_RETRY_FILES_ENABLED=0" -v $(shell pwd)/ansible-test:/playbook $(IMAGE_NAME) main.yml
	@echo =============Test Run Succeeded============

include $(TEMPLATE_DIR)/Makefile


.PHONY: test