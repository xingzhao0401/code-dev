FROM ubuntu:20.04
RUN echo deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse > /etc/apt/sources.list &&\
echo deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse >> /etc/apt/sources.list &&\
echo deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse >> /etc/apt/sources.list &&\
echo deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse >> /etc/apt/sources.list &&\
echo deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse >> /etc/apt/sources.list &&\
echo deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse >> /etc/apt/sources.list &&\
echo deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse >> /etc/apt/sources.list &&\
echo deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse >> /etc/apt/sources.list &&\
echo deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse >> /etc/apt/sources.list &&\
echo deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse >> /etc/apt/sources.list &&\
apt update &&\
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata &&\
apt-get install -y wget build-essential pkg-config libssl-dev software-properties-common &&\
apt upgrade -y intltool &&\
add-apt-repository ppa:longsleep/golang-backports &&\
apt update &&\
apt-get install -y golang-go &&\
apt-get clean &&\
wget http://jaist.dl.sourceforge.net/project/kmphpfm/mwget/0.1/mwget_0.1.0.orig.tar.bz2 &&\
tar -xjvf mwget_0.1.0.orig.tar.bz2 && cd mwget_0.1.0.orig && ./configure &&\
 sed -i '/<iostream>/a #include <cstring>' src/httpplugin.cpp &&\
 sed -i '/<iostream>/a #include <cstring>' src/ftpplugin.cpp &&\
 sed -i '/<sys\/types.h>/a #include <cstring>' src/downloader.cpp &&\
 make && make install &&\
wget https://github.com/cdr/code-server/releases/download/v3.8.0/code-server_3.8.0_amd64.deb &&\
dpkg -i code-server_3.8.0_amd64.deb && cd .. && rm -rf mwget_0.1.0.orig
ENV PASSWORD 123456
ENV PS1 \\u@\\w\\$
ENV GOPROXY https://goproxy.cn
ENV GO111MODULE on
ENV CGO_ENABLED 0
ENV PORT 8090
EXPOSE 8080
EXPOSE 8090
WORKDIR /home/project/
CMD ["code-server","/home/project/","--bind-addr","0.0.0.0:8080","--auth","password"]
