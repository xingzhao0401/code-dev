FROM alpine
LABEL description="这是一个基于alpine、code-server的开发环境" by="xingzhao0401" email="234454166@qq.com"
ENV CODE_SERVER_VERSION 3.4.1
ENV GO_EXTERN_VERSION 0.14.3
ENV PYTHON_EXTERN_VERSION 2020.7.94776
ENV Vetur_EXTERN_VERSION 0.24.0
ENV Vue2Snippets_EXTERN_VERSION 0.1.11
ENV AutoCloseTag_EXTERN_VERSION 0.5.5
ENV AutoRenameTag_EXTERN_VERSION 0.1.0
ENV PERL_DEBUG_EXTERN_VERSION 0.6.3
ENV CPPTOOLS_VERSION 0.29.0

RUN apk upgrade &&\
    apk add --no-cache vim bash go python2 python2-dev python3 python3-dev nodejs yarn npm dumb-init openssl musl-dev git perl-parallel-forkmanager perl &&\
    ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2 && \
    mkdir -p /home/project/ && mkdir -p /workdir && cd /workdir/ && \
   wget https://github.com/cdr/code-server/releases/download/$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-x86_64.tar.gz && \
   tar xzvf code-server-$CODE_SERVER_VERSION-linux-x86_64.tar.gz && \
   ln -s /workdir/code-server-$CODE_SERVER_VERSION-linux-x86_64 /workdir/code-server && \
   rm -f /workdir/code-server/lib/node && \
   ln -s /usr/bin/node /workdir/code-server/lib/node && \
   wget -O ms-go.vsix https://github.com/microsoft/vscode-go/releases/download/$GO_EXTERN_VERSION/Go-$GO_EXTERN_VERSION.vsix &&\
   wget -O ms-python.vsix https://github.com/microsoft/vscode-python/releases/download/$PYTHON_EXTERN_VERSION/ms-python-release.vsix && \
   wget -O ms-Vetur.vsix  https://github.com/vuejs/vetur/releases/download/v$Vetur_EXTERN_VERSION/vetur-$Vetur_EXTERN_VERSION.vsix &&\
   wget -O ms-Vue2Snippets.vsix https://github.com/hollowtree/vscode-vue-snippets/releases/download/v$Vue2Snippets_EXTERN_VERSION/vue-snippets-$Vue2Snippets_EXTERN_VERSION.vsix &&\
   wget -O ms-AutoCloseTag.vsix  https://github.com/formulahendry/vscode-auto-close-tag/releases/download/$AutoCloseTag_EXTERN_VERSION/auto-close-tag-$AutoCloseTag_EXTERN_VERSION.vsix &&\
   wget -O ms-AutoRenameTag.vsix  https://github.com/formulahendry/vscode-auto-rename-tag/releases/download/$AutoRenameTag_EXTERN_VERSION/auto-rename-tag-$AutoRenameTag_EXTERN_VERSION.vsix &&\
   wget -O perl-debug.vsix https://github.com/raix/vscode-perl-debug/releases/download/v$PERL_DEBUG_EXTERN_VERSION/mortenhenriksen.perl-debug.vsix  &&\
   wget -O cpptools.vsix https://github.com/microsoft/vscode-cpptools/releases/download/$CPPTOOLS_VERSION/cpptools-linux.vsix &&\
   /workdir/code-server/code-server --install-extension /workdir/ms-go.vsix &&\
   /workdir/code-server/code-server --install-extension /workdir/ms-python.vsix &&\
   /workdir/code-server/code-server --install-extension /workdir/ms-Vetur.vsix &&\
   /workdir/code-server/code-server --install-extension /workdir/ms-Vue2Snippets.vsix &&\
   /workdir/code-server/code-server --install-extension /workdir/ms-AutoCloseTag.vsix &&\
   /workdir/code-server/code-server --install-extension /workdir/ms-AutoRenameTag.vsix &&\
   /workdir/code-server/code-server --install-extension /workdir/perl-debug.vsix &&\
   /workdir/code-server/code-server --install-extension /workdir/cpptools.vsix &&\
   rm -f /workdir/code-server-*.tar.gz /workdir/*.vsix &&\
   npm config set registry http://registry.npm.taobao.org &&\
   yarn config set registry https://registry.npm.taobao.org/ &&\
   sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
   mkdir /root/.pip/ && echo [global]>/root/.pip/pip.conf && echo index-url = https://mirrors.aliyun.com/pypi/simple >> /root/.pip/pip.conf
   
ENV PASSWORD 123456
ENV PS1 \\u@\\w\\$
ENV GOPROXY https://goproxy.cn
ENV CGO_ENABLED 0
ENV PORT 8090
EXPOSE 8080
EXPOSE 8090
WORKDIR /home/project/
CMD ["dumb-init","/workdir/code-server/code-server","/home/project/","--bind-addr","0.0.0.0:8080","--auth","password","--disable-updates"]
