FROM pydemia/centos7-locale-zsh
MAINTAINER Youngju Jaden Kim <pydemia@gmail.com>

USER pydemia
WORKDIR /home/pydemia
RUN mkdir /home/pydemia/apps

COPY install_miniconda.sh .
COPY miniconda.bashrc .
COPY miniconda.zshrc .

COPY ./env-jupyter ./env-jupyter

RUN bash ./install_miniconda.sh
RUN bash ./env-jupyter/install_jupyter.sh
#RUN bash -ic "./env-jupyter/install_other_langs.sh"
#RUN bash -ic "./env-jupyter/install_kernel_python.sh"
#RUN bash -ic "./env-jupyter/install_kernel_r.sh"
#RUN bash -ic "./env-jupyter/install_kernel_julia.sh"
#RUN bash -ic 

CMD ["zsh"]