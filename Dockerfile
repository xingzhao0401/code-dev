FROM alpine
LABEL description="这是一个基于alpine、code-server的开发环境" by="xingzhao0401" email="234454166@qq.com"
ENV CODE_SERVER_VERSION 3.2.0
ENV WORKDIR /home/project/
RUN apk add --no-cache dumb-init nodejs go python3 python3-dev &&\
    ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2 && \
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
   sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
   pip3 install -i http://mirrors.aliyun.com/pypi/simple/
   
ENV PASSWORD 123456
ENV PS1 \\u@\\w\\$
ENV GOPROXY https://goproxy.cn
ENV CGO_ENABLED 0
EXPOSE 8080
WORKDIR $WORKDIR
CMD ["dumb-init","node","/workdir/code-server/out/node/entry.js","/home/project/","--host","0.0.0.0","--auth","password"]
