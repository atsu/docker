IMAGE_NAME=ghcr.io/atsu/alpine
TEMPLATE_DIR=../build-templates

kbuild: version
	docker build --build-arg VERSION="$(IMAGE_VERSION)" --build-arg IMAGE_NAME="$(IMAGE_NAME)" --rm -t $(IMAGE_NAME) .
	docker images | head -3

krun: kbuild
	docker run --rm -it $(IMAGE_NAME) sh

include $(TEMPLATE_DIR)/Makefile

.PHONY: kbuild krun
