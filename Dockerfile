FROM debian:bookworm

RUN apt-get update && apt-get install -y \
build-essential gawk gcc g++ gfortran git texinfo bison libncurses-dev

# Grab the compiler tar from the build and extract it
WORKDIR /compiler
ARG TAR_NAME
ARG TAR_PATH_NO_EXTENSION
ARG INSTALL_NAME
COPY "${TAR_PATH_NO_EXTENSION}.tar.gz" .
RUN tar -xvf "${TAR_NAME}.tar.gz"

# Set up the PATH and library path for the compiler
ENV PATH="/compiler/${INSTALL_NAME}/bin:$PATH"
# ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/compiler/${COMPILER_NAME}/lib"
# LD_LIBRARY_PATH is not set in the environment already
ENV LD_LIBRARY_PATH="/compiler/${INSTALL_NAME}/lib"

WORKDIR /workdir
SHELL ["/bin/bash", "-c"]