.SILENT:
SHELL = /bin/bash
TAG = slavik0/django-wiki
VERSION ?= "0.12.0"
HOST_PORT ?= 8000
ADMIN_USER ?= "admin"
ADMIN_PASSWORD ?= "admin"
ADMIN_EMAIL ?= "admin@example.org"

.PHONY: help
help:
	@grep -E '^[a-zA-Z\-\_0-9\.@]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; \
			{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:  ## Build docker image (VERSION)
	[[ "${VERSION}" ]] || (echo "VERSION param is required" && exit 1)
	echo " >> Building ${VERSION}"
	docker build \
		--build-arg VERSION=${VERSION} \
		-t ${TAG}:${VERSION} \
		-t $(TAG):$(shell date +%Y%m%d) \
		-t ${TAG}:latest .

push:  ## Push image to the registry
	docker push --all-tags ${TAG}

run:  ## Run a test instance (VERSION)
	docker run \
		--interactive \
		--tty \
		--publish ${HOST_PORT}:8000 \
		--name wiki \
		--env DEBUG=true \
		--env ADMIN_USER=${ADMIN_USER} \
		--env ADMIN_PASSWORD=${ADMIN_PASSWORD} \
		--env ADMIN_EMAIL=${ADMIN_EMAIL} \
		--rm \
		$(TAG):latest

.PHONY: clean
clean:
	docker images | grep -E "${TAG}|none" | awk '{print $$3}' | xargs docker rmi -f
