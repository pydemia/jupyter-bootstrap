FROM ubuntu:18.04
MAINTAINER Youngju Jaden Kim <pydemia@gmail.com>

#VOLUME ["/sys/fs/cgroup"]
#ENTRYPOINT ["/usr/sbin/init"]

USER root
COPY install_base.sh .
RUN ./install_base.sh LOCALE=ko_KR

ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR.UTF-8
ENV LC_ALL=ko_KR.UTF-8

RUN sed -i 's/^auth       required   pam_shells.so/auth       sufficient   pam_shells.so/' /etc/pam.d/chsh
COPY install_zsh.sh .
RUN ./install_zsh.sh
#RUN chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
# As user: pydemia
# RUN adduser pydemia && \
#     echo "pydemia ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/pydemia && \
#     chmod 0440 /etc/sudoers.d/pydemia

#USER pydemia
COPY install_zsh.sh /home/pydemia/install_zsh.sh
RUN chown pydemia:pydemia /home/pydemia/install_zsh.sh && \
    su - pydemia -c "cd ~;bash /home/pydemia/install_zsh.sh"

RUN chown -R pydemia:pydemia /home/pydemia/.oh-my-zsh

#RUN ["bash", "-c", "/home/pydemia/install_zsh.sh"]

ENV PYTHONENCODING=UTF-8
ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR.UTF-8
ENV LC_ALL=ko_KR.UTF-8

USER root
RUN sed -i 's/^auth       sufficient   pam_shells.so/auth       required   pam_shells.so/' /etc/pam.d/chsh

USER pydemia
WORKDIR /home/pydemia
ENV ZSH_THEME="cobalt2-pydemia"
CMD ["zsh"]
