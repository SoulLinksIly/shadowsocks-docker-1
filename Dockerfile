FROM ubuntu:trusty

MAINTAINER guolin <guo.lin@outlook.com>

RUN apt-get update && \
    apt-get install -y --force-yes -m python-pip python-m2crypto &&\
    
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
RUN echo "root:123456" | chpasswd
RUN sed -ri
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
EXPOSE 22

RUN pip install shadowsocks

ENV SS_SERVER_ADDR 0.0.0.0
ENV SS_SERVER_PORT 8388
ENV SS_PASSWORD 404979408qq
ENV SS_METHOD aes-256-cfb
ENV SS_TIMEOUT 300

ADD start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE $SS_SERVER_PORT

CMD ["sh", "-c", "/start.sh"]
