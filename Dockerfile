ARG VERSION=master

FROM python:3.9.16-slim-bullseye
LABEL version="1.2.0"

ARG VERSION

COPY ./bin /usr/local/bin

RUN chmod a+x /usr/local/bin/* && \
    apt-get update &&\
    apt-get install -y --no-install-suggests --no-install-recommends\
    gcc \
    g++ \
    git \
    libbz2-dev \
    liblz4-dev \
    zlib1g-dev \
    libsnappy-dev \
    libleveldb-dev \
    librocksdb-dev \
    && pip install uvloop \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/kyuupichan/electrumx.git \
    && cd electrumx \
    && git checkout ${VERSION} \
    && pip install -r requirements.txt \
    && python setup.py install \
    && apt purge -y \
    gcc \
    g++ \
    git \
    libbz2-dev \
    liblz4-dev \
    zlib1g-dev \
    libsnappy-dev \
    libleveldb-dev \
    librocksdb-dev \
    && rm -rf /tmp/*

VOLUME ["/data"]
ENV HOME=/data
ENV DB_DIRECTORY=/data
ENV SERVICES=tcp://:50001,ssl://:50002,wss://:50004,rpc://0.0.0.0:8000
ENV SSL_CERTFILE=/root/electrumdb/server.crt
ENV SSL_KEYFILE=/root/electrumdb/server.key
ENV ALLOW_ROOT=true
ENV CACHE_MB=10000
ENV MAX_SESSIONS=10000
ENV MAX_SEND=10000000
ENV MAX_RECV=10000000
ENV HOST=""

USER 65534

RUN mkdir /data/electrumdb
WORKDIR /data

EXPOSE 50001 50002 50004 8000

CMD ["init"]