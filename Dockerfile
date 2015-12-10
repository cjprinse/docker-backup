FROM phusion/baseimage
MAINTAINER c.prinse <prinse.c@gmail.com>

CMD ["/sbin/my_init"]

RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    fuse \
    dkms \
    davfs2 \
    ssmtp \
    wget \
    mysql-client

RUN cd /tmp
RUN wget https://github.com/jwilder/dockerize/releases/download/v0.0.4/dockerize-linux-amd64-v0.0.4.tar.gz
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.0.4.tar.gz
RUN rm dockerize-linux-amd64-v0.0.4.tar.gz

COPY docker/config/ /tmp/config
COPY docker/my_init.d/ etc/my_init.d
RUN chmod -R 700 /etc/my_init.d

COPY docker/service/ /etc/service/
RUN chmod -R 700 /etc/service/

RUN mkdir -p /mnt/backup




