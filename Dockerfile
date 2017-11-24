FROM debian:jessie-slim

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ca-certificates git dialog sudo \
    && useradd -d /home/pi -G sudo -m pi \
    && echo "pi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pi

USER pi

WORKDIR /home/pi

RUN git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git

CMD "/bin/bash"
