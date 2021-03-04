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
apt-get install -y wget build-essential pkg-config libssl-dev software-properties-common language-pack-zh-hans git &&\
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
wget https://github.com/cdr/code-server/releases/download/v3.9.0/code-server_3.9.0_amd64.deb &&\
dpkg -i code-server_3.9.0_amd64.deb && cd .. && rm -rf mwget_0.1.0.orig &&\
wget https://github.com/golang/vscode-go/releases/download/v0.22.1/go-0.22.1.vsix &&\
code-server --install-extension go-0.22.1.vsix &&\
rm -f go-0.22.1.vsix &&\
wget https://github.com/microsoft/vscode-cpptools/releases/download/1.1.3/cpptools-linux.vsix &&\
code-server --install-extension cpptools-linux.vsix &&\
rm -f cpptools-linux.vsix
wget https://github.com/microsoft/vscode-python/releases/download/2021.2.582707922/ms-python-release.vsix &&\
code-server --install-extension ms-python-release.vsix &&\
rm -f ms-python-release.vsix

ENV LANG "zh_CN.UTF-8"
ENV LANGUAGE "zh_CN:zh:en_US:en"
ENV PASSWORD 123456
ENV GOPROXY https://goproxy.cn
ENV GO111MODULE off
ENV CGO_ENABLED 0
EXPOSE 8080
EXPOSE 8090
WORKDIR /home/project/
CMD ["code-server","/home/project/","--bind-addr","0.0.0.0:8080","--auth","password"]
