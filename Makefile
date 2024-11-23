IMAGE_NAME = "joshuajerred/raspberry-pi-cross-compiler"
64_GCC_VERSION = "13.3.0"
64_OS_VERSION = "bookworm"
64_TAG = "64-gcc-$(64_GCC_VERSION)-$(64_OS_VERSION)"

list-build-targets:
	@echo "make targets: 'build-image-64'"

build-image-64:
	docker build --build-arg gcc_version=$(64_GCC_VERSION) --build-arg os_version=$(64_OS_VERSION) -t $(IMAGE_NAME):$(64_TAG) .
	docker tag $(IMAGE_NAME):$(64_TAG) $(IMAGE_NAME):$(64_TAG)