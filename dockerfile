FROM alpine
RUN mkdir -p /workdir && \
        apk add --no-cache node go gcc python
