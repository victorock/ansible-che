FROM registry.access.redhat.com/ubi7/ubi-init:latest

ADD files/ansible.repo /etc/yum.repos.d
COPY ansible /ansible/
WORKDIR /ansible

# yum install ansible is broken because of python-jinja2 is named
# as python2-python-jinja2
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
 yum install -y python2-pip && \
 pip install --upgrade pip
RUN pip install ansible==2.8
# end
RUN ansible-playbook main.yaml

ENV HOME /home/ansible
WORKDIR /projects
ENTRYPOINT [ "/entrypoint" ]
CMD tail -f /dev/null