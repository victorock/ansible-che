FROM centos:latest
MAINTAINER Victor da Costa - https://github.com/victorock/

ADD files/ansible.repo /etc/yum.repos.d
ADD files/requirements.txt /tmp

RUN yum install -y epel-release && \
    yum install -y bzip2 \
      gcc-c++ \
      gettext \
      git \
      make \
      python \
      python-pip \
      curl \
      ansible && \ 
    yum upgrade -y

RUN pip install --upgrade pip setuptools && \
    pip install -I -r /tmp/requirements.txt

RUN mkdir -p /home/user && \
    chgrp -R 0 /home/user && \
    chmod -R g=u /home/user
RUN chmod g=u /etc/passwd
ADD files/uid_entrypoint /uid_entrypoint
RUN chmod u+x /uid_entrypoint
ENTRYPOINT [ "/uid_entrypoint" ]
USER 1001
ENV HOME=/home/user
CMD tail -f /dev/null