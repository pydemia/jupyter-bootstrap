FROM pydemia/centos7-locale-zsh
MAINTAINER Youngju Jaden Kim <pydemia@gmail.com>

USER pydemia
WORKDIR /home/pydemia
RUN mkdir /home/pydemia/apps

COPY env-jupyter/install_miniconda.sh .
COPY env-jupyter/miniconda.bashrc .
COPY env-jupyter/miniconda.zshrc .

COPY env-jupyter ./env-jupyter

RUN bash ./install_miniconda.sh
RUN bash ./env-jupyter/install_jupyter.sh

RUN rm -f ./install_miniconda.sh miniconda.bashrc miniconda.zshrc
RUN rm -rf ./env-jupyter


CMD ["zsh"]