FROM alpine
LABEL description="这是一个基于alpine、code-server的开发环境" by="xingzhao0401" email="234454166@qq.com"
ENV CODE_SERVER_VERSION 3.2.0
ENV GO_EXTERN_VERSION 0.14.1
ENV PYTHON_EXTERN_VERSION 2020.4.76186
ENV Vetur_EXTERN_VERSION 0.24.0
ENV Vue2Snippets_EXTERN_VERSION 0.1.11
ENV AutoCloseTag_EXTERN_VERSION 0.5.5
ENV AutoRenameTag_EXTERN_VERSION 0.1.0

RUN apk add --no-cache vim bash go python python-dev py2-pip python3 python3-dev nodejs npm dumb-init openssl musl-dev  &&\
    ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2 && \
    mkdir -p /home/project/ && mkdir -p /workdir && cd /workdir/ && \
   wget https://github.com/cdr/code-server/releases/download/$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-x86_64.tar.gz && \
   tar xzvf code-server-$CODE_SERVER_VERSION-linux-x86_64.tar.gz && \
   ln -s /workdir/code-server-$CODE_SERVER_VERSION-linux-x86_64 /workdir/code-server && \
   wget -O ms-go.vsix https://github.com/microsoft/vscode-go/releases/download/$GO_EXTERN_VERSION/Go-$GO_EXTERN_VERSION.vsix &&\
   wget -O ms-python.vsix https://github.com/microsoft/vscode-python/releases/download/$PYTHON_EXTERN_VERSION/ms-python-release.vsix && \
   wget -O ms-Vetur.vsix  https://github.com/vuejs/vetur/releases/download/v$Vetur_EXTERN_VERSION/vetur-$Vetur_EXTERN_VERSION.vsix &&\
   wget -O ms-Vue2Snippets.vsix https://github.com/hollowtree/vscode-vue-snippets/releases/download/v$Vue2Snippets_EXTERN_VERSION/vue-snippets-$Vue2Snippets_EXTERN_VERSION.vsix &&\
   wget -O ms-AutoCloseTag.vsix  https://github.com/formulahendry/vscode-auto-close-tag/releases/download/$AutoCloseTag_EXTERN_VERSION/auto-close-tag-$AutoCloseTag_EXTERN_VERSION.vsix &&\
   wget -O ms-AutoRenameTag.vsix  https://github.com/formulahendry/vscode-auto-rename-tag/releases/download/$AutoRenameTag_EXTERN_VERSION/auto-rename-tag-$AutoRenameTag_EXTERN_VERSION.vsix &&\
   node /workdir/code-server/out/node/entry.js --install-extension /workdir/ms-go.vsix &&\
   node /workdir/code-server/out/node/entry.js --install-extension /workdir/ms-python.vsix &&\
   node /workdir/code-server/out/node/entry.js --install-extension /workdir/ms-Vetur.vsix &&\
   node /workdir/code-server/out/node/entry.js --install-extension /workdir/ms-Vue2Snippets.vsix &&\
   node /workdir/code-server/out/node/entry.js --install-extension /workdir/ms-AutoCloseTag.vsix &&\
   node /workdir/code-server/out/node/entry.js --install-extension /workdir/ms-AutoRenameTag.vsix &&\
   rm -f /workdir/code-server-*.tar.gz /workdir/ms-go.vsix /workdir/ms-python.vsix /workdir/ms-Vetur.vsix /workdir/ms-Vue2Snippets.vsix /workdir/ms-AutoCloseTag.vsix /workdir/ms-AutoRenameTag.vsix &&\
   npm config set registry http://registry.npm.taobao.org &&\
   sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
   mkdir /root/.pip/ && echo [global]>/root/.pip/pip.conf && echo index-url = https://mirrors.aliyun.com/pypi/simple >> /root/.pip/pip.conf
   
ENV PASSWORD 123456
ENV PS1 \\u@\\w\\$
ENV GOPROXY https://goproxy.cn
ENV CGO_ENABLED 0
EXPOSE 8080
WORKDIR /home/project/
CMD ["dumb-init","node","/workdir/code-server/out/node/entry.js","/home/project/","--host","0.0.0.0","--auth","password"]
