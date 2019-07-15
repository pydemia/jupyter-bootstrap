FROM ubuntu:18.04

#VOLUME ["/sys/fs/cgroup"]
#ENTRYPOINT ["/usr/sbin/init"]

COPY install_base.sh .
RUN ./install_base.sh LOCALE=ko_KR

RUN sed -i 's/^auth       required   pam_shells.so/auth       sufficient   pam_shells.so/' /etc/pam.d/chsh
COPY install_zsh.sh .
RUN ./install_zsh.sh
RUN sed -i 's/^auth       sufficient   pam_shells.so/auth       required   pam_shells.so/' /etc/pam.d/chsh
# As user: pydemia
# RUN adduser pydemia && \
#     echo "pydemia ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/pydemia && \
#     chmod 0440 /etc/sudoers.d/pydemia

RUN sed -i 's/^auth       required   pam_shells.so/auth       sufficient   pam_shells.so/' /etc/pam.d/chsh
COPY install_zsh.sh /home/pydemia/
RUN chmod 644 /home/pydemia/install_zsh.sh && \
    su - pydemia -c "cd ~;bash /home/pydemia/install_zsh.sh"
RUN sed -i 's/^auth       sufficient   pam_shells.so/auth       required   pam_shells.so/' /etc/pam.d/chsh

ENV PYTHONENCODING=UTF-8
ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR.UTF-8
ENV LC_ALL=ko_KR.UTF-8

#CMD ["/usr/bin/bash"]
ENTRYPOINT ["zsh"]
#ENTRYPOINT ["su", "-", "pydemia", "-c", "zsh"]
#CMD ["su", "-", "pydemia", "-c", "zsh"]