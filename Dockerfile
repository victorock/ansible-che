FROM centos:latest
MAINTAINER Victor da Costa - https://github.com/victorock/

ADD files/ansible.repo /etc/yum.repos.d
COPY ansible /ansible/
WORKDIR /ansible

RUN yum install -y ansible
RUN ansible-playbook main.yaml

USER ansible
ENV HOME /home/ansible
WORKDIR /projects
ENTRYPOINT [ "/entrypoint" ]
CMD tail -f /dev/null