FROM python:3.9.5-alpine3.13
LABEL maintainer="ChainBow Team <support@chainbow.io>"
#inspired from "Luke Childs <lukechilds123@gmail.com>"

COPY ./bin /usr/local/bin

ARG VERSION=1.19.0

RUN chmod a+x /usr/local/bin/* && \
    apk add --no-cache git build-base openssl && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.11/main leveldb-dev && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing rocksdb-dev && \
    pip install aiohttp aiorpcx pylru plyvel websockets python-rocksdb uvloop && \
    git clone -b $VERSION https://github.com/kyuupichan/electrumx.git && \
    cd electrumx && \
    python setup.py install && \
    apk del git build-base && \
    rm -rf /tmp/*

VOLUME ["/data"]
ENV HOME /data
ENV ALLOW_ROOT 1
ENV EVENT_LOOP_POLICY uvloop
ENV DB_DIRECTORY /data
ENV SERVICES=tcp://:50001,ssl://:50002,wss://:50004,rpc://0.0.0.0:8000
ENV SSL_CERTFILE ${DB_DIRECTORY}/electrumx.crt
ENV SSL_KEYFILE ${DB_DIRECTORY}/electrumx.key
ENV HOST ""
WORKDIR /data

EXPOSE 50001 50002 50004 8000

CMD ["init"]
