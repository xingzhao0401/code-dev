FROM alpine
RUN apk add --no-cache nodejs go gcc python &&\
    mkdir -p /workdir && cd /workdir/ && \
   wget -O code-server.tar.gz https://github.com/cdr/code-server/releases/download/3.2.0/code-server-3.2.0-linux-x86_64.tar.gz && \
   wget -O ms-go.vsix https://github.com/microsoft/vscode-go/releases/download/0.14.1/Go-0.14.1.vsix &&\
   wget -O ms-python.vsix https://github.com/microsoft/vscode-python/releases/download/2020.4.76186/ms-python-release.vsix && \
   tar xzvf code-server.tar.gz && \
   cd code-server && \
   ./code-server --install-extension ../ms-go.vsix &&\
   ./code-server --install-extension ../ms-python.vsix &&\
   rm -f code-server-3.2.0-linux-x86_64.tar.gz ms-go.vsix ms-python.vsix &&\
   sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
ENV PASSWORD 123456
ENV PS1 \\u@\\w \\$
ENV GOPROXY https://goproxy.cn
ENV CGO_ENABLED 0
CMD ["dumb-init","node","/workdir/code-server/out/node/entry.js","/home/project/","--host","0.0.0.0","--auth","password","--disable-ssh"]
