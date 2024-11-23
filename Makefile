IMAGE_NAME = "joshuajerred/raspberry-pi-cross-compiler"
64_GCC_VERSION = "12.2.0"
64_OS_VERSION = "bookworm"
64_TAG = "64-gcc-$(64_GCC_VERSION)-$(64_OS_VERSION)"

BUILD_DIR = "build"
BUILD_PATH = $(CURDIR)/$(BUILD_DIR)

OUTPUT_DIR = "$(BUILD_DIR)/out"
OUTPUT_PATH = $(CURDIR)/$(OUTPUT_DIR)

TAR_NAME = "cross-gcc-$(64_GCC_VERSION)-pi_64"
TAR_PATH_NO_EXTENSION = "./$(OUTPUT_DIR)/$(TAR_NAME)"
INSTALL_NAME = "cross-pi-gcc-$(64_GCC_VERSION)-64"

catch-all:
	@echo "specify a task - see README.md"

install-prerequisites:
	sudo apt update && sudo apt install -y \
    gcc g++ gperf flex texinfo gawk gfortran texinfo \
    bison build-essential openssl unzip wget git pigz libgmp-dev \
    libncurses-dev autoconf automake tar figlet libmpfr-dev rsync \
    python3 libmpc-dev git

build-compiler:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OUTPUT_DIR)
	export HOME=$(OUTPUT_PATH) && export BUILDDIR=$(BUILD_PATH) && \
		bash ./raspberry-pi-cross-compilers/build-scripts/RTBuilder_64b \
		-g $(64_GCC_VERSION) -o $(64_OS_VERSION)

build-image:
	docker build --progress=plain \
		--build-arg TAR_NAME=$(TAR_NAME) \
		--build-arg TAR_PATH_NO_EXTENSION=$(TAR_PATH_NO_EXTENSION) \
		--build-arg INSTALL_NAME=$(INSTALL_NAME) \
		-t $(IMAGE_NAME):$(64_TAG) .
# docker tag $(IMAGE_NAME):$(64_TAG) $(IMAGE_NAME):$(64_TAG)

push-image:
	docker push $(IMAGE_NAME):$(64_TAG)

run: build-image
	docker run --rm -it joshuajerred/raspberry-pi-cross-compiler:64-gcc-12.2.0-bookworm /bin/bash

get-compiler-version:
	@echo $(64_TAG)

clean:
	rm -rf $(BUILD_DIR)/