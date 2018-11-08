FROM centos:7
MAINTAINER Victor da Costa - https://github.com/victorock/

ADD files/ansible.repo /etc/yum.repos.d
ADD files/requirements.txt /tmp

RUN yum install -y epel-release
RUN yum install -y bzip2 \
    gcc-c++ \
    gettext \
    git \
    make \
    python \
    python-pip \
    ansible

RUN pip install -r /tmp/requirements.txt

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