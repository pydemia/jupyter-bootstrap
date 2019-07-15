FROM centos:centos7

# ENV container docker

# RUN yum -y update; yum clean all
# RUN yum -y install systemd; yum clean all; \
# (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
# rm -f /lib/systemd/system/multi-user.target.wants/*;\
# rm -f /etc/systemd/system/*.wants/*;\
# rm -f /lib/systemd/system/local-fs.target.wants/*; \
# rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
# rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
# rm -f /lib/systemd/system/basic.target.wants/*;\
# rm -f /lib/systemd/system/anaconda.target.wants/*;


#VOLUME ["/sys/fs/cgroup"]
#ENTRYPOINT ["/usr/sbin/init"]

COPY install_base.sh .
RUN ./install_base.sh LOCALE=ko_KR

COPY install_zsh.sh .
RUN ./install_zsh.sh

# As user: pydemia
# RUN adduser pydemia && \
#     echo "pydemia ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/pydemia && \
#     chmod 0440 /etc/sudoers.d/pydemia

COPY install_zsh.sh /home/pydemia/
RUN chmod 644 /home/pydemia/install_zsh.sh && \
    su - pydemia -c "cd ~;bash /home/pydemia/install_zsh.sh"


ENV LANG=ko_KR.utf8
ENV LC_ALL=ko_KR.utf8
#CMD ["/usr/bin/bash"]
CMD ["su", "-", "pydemia", "-c", "/usr/bin/zsh"]