FROM alpine
RUN apk add --no-cache node go gcc python &&\
    mkdir -p /workdir && cd /workdir/ && \
   wget https://github.com/cdr/code-server/releases/download/3.2.0/code-server-3.2.0-linux-x86_64.tar.gz && \
   tar xzvf code-server-3.2.0-linux-x86_64.tar.gz && \
   rm code-server-3.2.0-linux-x86_64.tar.gz
