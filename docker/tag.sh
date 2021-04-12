#!/usr/bin/env bash

# find L4T_VERSION
source scripts/l4t-version.sh

# local container:tag name
CONTAINER_IMAGE="jetstream:r$L4T_VERSION"

# incompatible L4T version
function version_error()
{
	echo "cannot find compatible jetson-inference docker container for L4T R$L4T_VERSION"
	echo "please upgrade to the latest JetPack, or build jetson-inference natively from source"
	exit 1
}
	
# check for local image
if [[ "$(sudo docker images -q $CONTAINER_IMAGE 2> /dev/null)" == "" ]]; then
	CONTAINER_IMAGE=$CONTAINER_REMOTE_IMAGE
fi