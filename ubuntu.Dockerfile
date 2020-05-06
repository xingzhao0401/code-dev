FROM ubuntu:20.04
LABEL description="这是一个基于ubuntu、code-server的开发环境" by="xingzhao0401" email="234454166@qq.com"
ENV CODE_SERVER_VERSION 3.2.0
ENV WORKDIR /home/project/
RUN apt-get update &&\
    apt-get install -y g++ python python3 python3-pip dumb-init nodejs golang  &&\
    mkdir -p $WORKDIR && mkdir -p /workdir && cd /workdir/ && \
   wget https://github.com/cdr/code-server/releases/download/$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-x86_64.tar.gz && \
   tar xzvf code-server-$CODE_SERVER_VERSION-linux-x86_64.tar.gz && \
   ln -s /workdir/code-server-$CODE_SERVER_VERSION-linux-x86_64 /workdir/code-server && \
   wget -O ms-go.vsix https://github.com/microsoft/vscode-go/releases/download/0.14.1/Go-0.14.1.vsix &&\
   wget -O ms-python.vsix https://github.com/microsoft/vscode-python/releases/download/2020.4.76186/ms-python-release.vsix && \
   cd code-server && \
   node /workdir/code-server/out/node/entry.js --install-extension ../ms-go.vsix &&\
   node /workdir/code-server/out/node/entry.js --install-extension ../ms-python.vsix &&\
   rm -f code-server-*.tar.gz ms-go.vsix ms-python.vsix &&\
   echo deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse  > /etc/apt/sources.list &&\
   echo deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse  >> /etc/apt/sources.list &&\
   mkdir /root/.pip/ && echo [global]>/root/.pip/pip.conf && echo index-url = https://mirrors.aliyun.com/pypi/simple >> /root/.pip/pip.conf &&\
   apt-get clean && apt-get autoclean
   
ENV PASSWORD 123456
ENV PS1 '\\u@\\w\\$ '
ENV GOPROXY https://goproxy.cn
ENV CGO_ENABLED 0
EXPOSE 8080
WORKDIR $WORKDIR
CMD ["dumb-init","node","/workdir/code-server/out/node/entry.js","/home/project/","--host","0.0.0.0","--auth","password"]
