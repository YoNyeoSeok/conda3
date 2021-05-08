#!/bin/bash
NAME=yonyeoseok/conda3:local
CUDA=11.2.2

docker pull yonyeoseok/conda3:cuda$CUDA-cudnn8-devel-ubuntu18.04
docker tag yonyeoseok/conda3:cuda$CUDA-cudnn8-devel-ubuntu18.04 $NAME

docker run --name tmp $NAME /bin/bash -c "
	useradd -m -u $UID -G sudo,conda $USER && \
	echo '$USER:passwd' | chpasswd"
docker commit tmp $NAME
docker rm tmp

docker run --name tmp -u $USER $NAME /bin/bash -c "
	runuser -l $USER -c '/opt/conda/bin/conda init'"
docker commit tmp $NAME
docker rm tmp

docker run --name tmp $NAME /bin/bash
docker commit tmp $NAME
docker rm tmp