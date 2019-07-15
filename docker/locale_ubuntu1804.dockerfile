FROM ubuntu:18.04

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