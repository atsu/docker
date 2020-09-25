IMAGE_NAME=ghcr.io/atsu/curator
TEMPLATE_DIR=../build-templates

kbuild: version
	docker build --rm -t $(IMAGE_NAME) .
	docker images | head -3

krun: kbuild
	docker run --rm -it $(IMAGE_NAME) sh

include $(TEMPLATE_DIR)/Makefile

.PHONY: kbuild krun
