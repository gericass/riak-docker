FROM ubuntu:16.04

MAINTAINER Keita Takahashi luckymortality@gmail.com

RUN ["/bin/bash", "-c"," \
    apt-get update; apt-get install -y curl \
    && curl -s https://packagecloud.io/install/repositories/basho/riak/script.deb.sh | bash \
    && apt-get install -y riak=2.2.3-1 \
    && cd /etc/riak \
    && sed -i '/listener/d' riak.conf \
    && echo 'listener.http.internal = 0.0.0.0:8098' >> riak.conf \
    && echo 'listener.protobuf.internal = 0.0.0.0:8087' >> riak.conf \
    && echo 'nodename = riak@192.168.33.11' >> riak.conf \
    && echo 'storage_backend = leveldb' >> riak.conf \
    && rm -fr /var/lib/riak/ring/ \
    "]
    
CMD riak start