#!/usr/bin/env bash

# find container tag from L4T version
source docker/tag.sh

DOCKER_ROOT="/jetstream"

# generate mount commands
DATA_VOLUME="--volume $PWD/data:$DOCKER_ROOT/data"

# check for V4L2 devices
V4L2_DEVICES=" "

for i in {0..9}
do
	if [ -a "/dev/video$i" ]; then
		V4L2_DEVICES="$V4L2_DEVICES --device /dev/video$i "
	fi
done

echo "V4L2_DEVICES:  $V4L2_DEVICES"

# run the container
sudo xhost +si:localuser:root

sudo docker run --runtime nvidia -it --rm --network host -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix/:/tmp/.X11-unix \
    -v /tmp/argus_socket:/tmp/argus_socket \
    -v /etc/enctune.conf:/etc/enctune.conf \
    $V4L2_DEVICES $DATA_VOLUME \
    $CONTAINER_IMAGE