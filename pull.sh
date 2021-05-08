#!/bin/bash
NAME=conda3
CUDA=$(/usr/local/cuda/bin/nvcc --version | tail -1 | cut -d ',' -f2 | cut -d ' ' -f3)

docker pull yonyeoseok/conda3:cuda$CUDA-cudnn7-devel-ubuntu16.04
docker tag yonyeoseok/conda3:cuda$CUDA-cudnn7-devel-ubuntu16.04 $NAME

docker run --name tmp $NAME /bin/bash -c "
	useradd -m -u $UID -G sudo,conda $NAME && \
	echo '$NAME:passwd' | chpasswd"
docker commit tmp $NAME
docker rm tmp

docker run --name $NAME -u $NAME $NAME /bin/bash -c "
	runuser -l $NAME -c '/opt/conda/bin/conda init'"
docker commit tmp $NAME
docker rm tmp

docker run --name tmp $NAME /bin/bash
docker commit tmp $NAME
docker rm tmp