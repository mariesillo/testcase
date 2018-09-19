FROM ubuntu:16.04

MAINTAINER mariesillo@gmail.com 

RUN apt-get update && \
    apt-get install -y sshd netcat stress && \
    sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config && \
    echo "root:${ROOT_PASSWORD}" | chpasswd 

COPY entrypoint.sh

EXPOSE 22

ENTRYPOINT ["./entrypoint.sh"]
