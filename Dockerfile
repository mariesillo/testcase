FROM ubuntu:16.04
MAINTAINER mariesillo@gmail.com

RUN apt-get update

RUN apt-get install -y openssh-server netcat stress
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd


COPY ./sshkey.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh/authorized_keys


RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./checkMem.sh /

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
