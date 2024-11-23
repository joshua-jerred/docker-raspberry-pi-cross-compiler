IMAGE_NAME = "joshuajerred/raspberry-pi-cross-compiler"
64_GCC_VERSION = "12.2.0"
64_OS_VERSION = "bookworm"
64_TAG = "64-gcc-$(64_GCC_VERSION)-$(64_OS_VERSION)"

BUILD_DIR = "build"
BUILD_PATH = $(CURDIR)/$(BUILD_DIR)

OUTPUT_DIR = "$(BUILD_DIR)/out"
OUTPUT_PATH = $(CURDIR)/$(OUTPUT_DIR)

COMPILER_NAME = "cross-gcc-$(64_GCC_VERSION)-pi_64"
COMPILER_TAR_PATH_NO_EXTENSION = "./$(OUTPUT_DIR)/$(COMPILER_NAME)"

build-setup:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OUTPUT_DIR)

build-compiler-64: build-setup
	export HOME=$(OUTPUT_PATH) && export BUILDDIR=$(BUILD_PATH) && \
		bash ./raspberry-pi-cross-compilers/build-scripts/RTBuilder_64b \
		-g $(64_GCC_VERSION) -o $(64_OS_VERSION)

build-image-64:
	docker build --progress=plain \
		--build-arg COMPILER_NAME=$(COMPILER_NAME) \
		--build-arg COMPILER_TAR_PATH_NO_EXT=$(COMPILER_TAR_PATH_NO_EXTENSION) \
		-t $(IMAGE_NAME):$(64_TAG) .
	docker tag $(IMAGE_NAME):$(64_TAG) $(IMAGE_NAME):$(64_TAG)

run:
	docker run --rm -it joshuajerred/raspberry-pi-cross-compiler:64-gcc-12.2.0-bookworm /bin/bash