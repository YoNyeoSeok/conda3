# NVIDIA_CUDA
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04

# Miniconda3
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion && \
    apt-get clean

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean --all --yes
RUN useradd -M conda && \
    chgrp -R conda /opt/conda && \
    chmod 770 -R /opt/conda

# entry point
CMD ["/bin/bash"]