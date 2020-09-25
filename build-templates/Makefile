# To use/include this base Makefile, the following variables must be defined *before* the include directive:

# BUILDER_NAME=<the name of the builder being created>
# IMAGE_NAME=<docker image name>
# SQRL_IMAGE_VERSION=<image tag of the sqrl image to use>
# TEMPLATE_DIR=<the path to the directory that contains the build templates>

build: dockerfile
	docker build --rm -t $(IMAGE_NAME) .
	docker images $(IMAGE_NAME)

dockerfile: $(TEMPLATE_DIR)/* $(BUILDER_NAME).m4 version
	rm -f Dockerfile
	m4 -DSQRL_VERSION=$(SQRL_IMAGE_VERSION) \
		-DBUILDER_TYPE=$(BUILDER_NAME) \
		-DIMAGE_VERSION=$(IMAGE_VERSION) \
		-I $(TEMPLATE_DIR) \
		$(BUILDER_NAME).m4 > Dockerfile
	cat Dockerfile

run: build
	docker run --rm -it $(IMAGE_NAME) sh

version:
	$(eval IMAGE_VERSION = $(shell docker run --rm -v $$(dirname $$(pwd)):/src \
		-e BUILD_ENV="$$(env | grep "USER\|TRAVIS\|ATSU")"  \
		-e ATSU_MAJOR_VERSION=0 ghcr.io/atsu/sqrl info -v version))
	@echo $(IMAGE_VERSION)

push: version
	@echo tagging and pushing using tag: $(IMAGE_VERSION)
	docker tag $(IMAGE_NAME) $(IMAGE_NAME):latest
	docker tag $(IMAGE_NAME) $(IMAGE_NAME):$(IMAGE_VERSION)
	docker images | head -3
	docker push $(IMAGE_NAME):latest
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)

clean:
	rm -f Dockerfile

.PHONY: build clean version push
