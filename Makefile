IMAGE_NAME=git.simarmannsingh.com/simarmannsingh/excalidraw
GIT_SHA1 := $(shell git rev-parse --short=10 --verify HEAD)
TIME_EPOCH := $(shell date +"%s")
PLATFORM = --platform linux/arm64

# UNAME := $(shell uname -m)
# ifeq ($(UNAME), arm64)
#   PLATFORM = --platform linux/amd64
# else
#   PLATFORM =
# endif

build-img:
	docker buildx build $(PLATFORM) \
		-t $(IMAGE_NAME):latest \
		-t $(IMAGE_NAME):$(GIT_SHA1)$(TIME_EPOCH) .
	
push:
	docker push $(IMAGE_NAME):latest
	docker push $(IMAGE_NAME):$(GIT_SHA1)$(TIME_EPOCH)

run: build-img
	docker run -p 80:80 $(IMAGE_NAME):$(GIT_SHA1)$(TIME_EPOCH)

deploy: build-img push