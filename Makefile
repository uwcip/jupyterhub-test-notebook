# stop on error, no built in rules, run silently
MAKEFLAGS="-S -s -r"

# set the image name
IMAGE_NAME := "ghcr.io/uwcip/jupyterhub-test-notebook"
IMAGE_ID := "latest"

all: build

.PHONY: build
build:
	@echo "building image for ${IMAGE_ID}"
	docker build --progress plain -t $(IMAGE_NAME):latest .

.PHONY: push
push: build
	@echo "pushing $(IMAGE_ID)"
	docker tag $(IMAGE_NAME):latest $(IMAGE_ID)
	docker push $(IMAGE_ID)

.PHONY: clean
clean:
	@echo "removing built image ${IMAGE_ID}"
	docker image rm -f $(IMAGE_NAME):latest $(IMAGE_ID)

.PHONY: pull
pull:
	@echo "pulling built image ${IMAGE_ID}"
	docker pull $(IMAGE_ID)
