FROM centos:centos7
MAINTAINER Youngju Jaden Kim <pydemia@gmail.com>

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

USER root
COPY install_base.sh .
RUN ./install_base.sh LOCALE=ko_KR

ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR.UTF-8
ENV LC_ALL=ko_KR.UTF-8

RUN echo -e "/bin/zsh\n/usr/bin/zsh\n" >> /etc/shells
RUN sed -i 's/^auth       required   pam_shells.so/auth       sufficient   pam_shells.so/' /etc/pam.d/chsh
COPY install_zsh.sh .
RUN ./install_zsh.sh

# As user: pydemia
# RUN adduser pydemia && \
#     echo "pydemia ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/pydemia && \
#     chmod 0440 /etc/sudoers.d/pydemia

COPY install_zsh.sh /home/pydemia/
RUN chown pydemia:pydemia /home/pydemia/install_zsh.sh && \
    su - pydemia -c "cd ~;bash /home/pydemia/install_zsh.sh"

RUN chown -R pydemia:pydemia /home/pydemia/.oh-my-zsh

ENV PYTHONENCODING=UTF-8
ENV LANG=ko_KR.UTF-8
ENV LANG=ko_KR.UTF-8
ENV LC_ALL=ko_KR.UTF-8

USER root
RUN sed -i 's/^auth       sufficient   pam_shells.so/auth       required   pam_shells.so/' /etc/pam.d/chsh


USER pydemia
WORKDIR /home/pydemia
ENV ZSH_THEME="cobalt2-pydemia"
CMD ["zsh"]
#CMD ["su", "-", "pydemia", "-c", "/usr/bin/zsh"]