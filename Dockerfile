FROM fedora:latest

RUN dnf install -y gcc-c++ cmake ninja-build libX11-devel libXcursor-devel libXi-devel mesa-libGL-devel fontconfig-devel \
  	&& dnf clean all \
  	&& rm -rf /var/cache/yum

RUN mkdir /code

WORKDIR /code

ENTRYPOINT ./build.sh