FROM ubuntu:16.04

MAINTAINER Keita Takahashi luckymortality@gmail.com

RUN apt-get update; apt-get install -y curl 
RUN curl -s https://packagecloud.io/install/repositories/basho/riak/script.deb.sh | bash 
RUN apt-get install -y riak=2.2.3-1 
RUN sed -i '/listener/d' /etc/riak/riak.conf 
RUN echo 'listener.http.internal = 0.0.0.0:8098' >> /etc/riak/riak.conf 
RUN echo 'listener.protobuf.internal = 0.0.0.0:8087' >> /etc/riak/riak.conf 
RUN echo 'nodename = riak@127.0.0.1' >> /etc/riak/riak.conf 
RUN echo 'storage_backend = leveldb' >> /etc/riak/riak.conf 
RUN rm -fr /var/lib/riak/ring/ 
    
EXPOSE 8098

ENTRYPOINT ["riak", "start"]