#!/bin/bash
IMAGE=yonyeoseok/conda3
NAME=conda3

# for CUDA in 10.0 9.0
# do
# 	TAG=cuda$CUDA-cudnn7-devel-ubuntu16.04
# 	docker build -t $IMAGE:$TAG --build-arg CUDA=$CUDA .
# 	docker push $IMAGE:$TAG
# done

# for CUDA in 11.2.1
# do
# 	TAG=$CUDA-cudnn8-devel-ubuntu16.04
# 	docker build -t $IMAGE:cuda$TAG --build-arg TAG=$TAG .
# 	docker push $IMAGE:cuda$TAG
# done

for CUDA in 11.2.1 11.2.2
do
	TAG=$CUDA-cudnn8-devel-ubuntu18.04
	docker build -t $IMAGE:cuda$TAG --build-arg TAG=$TAG .
	docker push $IMAGE:cuda$TAG
done
