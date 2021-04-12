BASE_IMAGE=$1

# find L4T_VERSION
source scripts/l4t-version.sh

if [ -z $BASE_IMAGE ]; then
	if [ $L4T_VERSION = "32.5.1" ]; then
		BASE_IMAGE="nvcr.io/nvidia/l4t-pytorch:r32.5.0-pth1.6-py3"
	elif [ $L4T_VERSION = "32.5.0" ]; then
		BASE_IMAGE="nvcr.io/nvidia/l4t-pytorch:r32.5.0-pth1.6-py3"
	elif [ $L4T_VERSION = "32.4.4" ]; then
		BASE_IMAGE="nvcr.io/nvidia/l4t-pytorch:r32.4.4-pth1.6-py3"
	elif [ $L4T_VERSION = "32.4.3" ]; then
		BASE_IMAGE="nvcr.io/nvidia/l4t-pytorch:r32.4.3-pth1.6-py3"
	elif [ $L4T_VERSION = "32.4.2" ]; then
		BASE_IMAGE="nvcr.io/nvidia/l4t-pytorch:r32.4.2-pth1.5-py3"
	else
		echo "cannot build jetson-inference docker container for L4T R$L4T_VERSION"
		echo "please upgrade to the latest JetPack, or build jetson-inference natively"
		exit 1
	fi
fi

echo "BASE_IMAGE=$BASE_IMAGE"
echo "TAG=jetstream:r$L4T_VERSION"

# build the container
sudo docker build -t jetstream:r$L4T_VERSION -f Dockerfile \
          --build-arg BASE_IMAGE=$BASE_IMAGE .
