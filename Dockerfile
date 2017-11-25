FROM ubuntu:16.04

ENV CUDA_RUN http://developer.nvidia.com/compute/cuda/8.0/Prod/local_installers/cuda_8.0.44_linux-run

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends wget build-essential module-init-tools ca-certificates git dialog sudo \
    && useradd -d /home/pi -G sudo -m pi \
    && echo "pi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pi
    
RUN cd /opt && \
  wget $CUDA_RUN && \
  mv /opt/cuda_8.0.44_linux-run /opt/cuda_8.0.44_linux.run && \
  chmod +x *.run && \
  mkdir nvidia_installers && \
  ./cuda_8.0.44_linux.run -extract=`pwd`/nvidia_installers && \
  cd nvidia_installers && \
  ./NVIDIA-Linux-x86_64-367.48.run -s -N --no-kernel-module && \
  ./cuda-linux64-rel-8.0.44-21122537.run -noprompt
  
# Ensure the CUDA libs and binaries are in the correct environment variables
ENV LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-8.0/lib64
ENV PATH=$PATH:/usr/local/cuda-8.0/bin

USER pi

WORKDIR /home/pi

RUN git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git

CMD "/bin/bash"
