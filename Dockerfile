FROM phusion/baseimage
MAINTAINER c.prinse <prinse.c@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    fuse \
    dkms \
    davfs2

RUN mkdir /mnt/backup

COPY backup.sh /opt/

CMD ["/bin/bash", "/opt/backup.sh"]
