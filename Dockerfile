FROM debian:bookworm

RUN apt-get update && apt-get install -y \
build-essential gawk gcc g++ gfortran git texinfo bison libncurses-dev

# Grab the compiler tar from the build and extract it
WORKDIR /compiler
ARG COMPILER_NAME
ARG COMPILER_TAR_PATH_NO_EXT
COPY "${COMPILER_TAR_PATH_NO_EXT}.tar.gz" .
RUN tar -xvf "${COMPILER_NAME}.tar.gz"

# Set up the PATH and library path for the compiler
ENV PATH="/compiler/${COMPILER_NAME}/bin:$PATH"
# ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/compiler/${COMPILER_NAME}/lib"
# LD_LIBRARY_PATH is not set in the environment already
ENV LD_LIBRARY_PATH="/compiler/${COMPILER_NAME}/lib"

WORKDIR /workdir
SHELL ["/bin/bash", "-c"]