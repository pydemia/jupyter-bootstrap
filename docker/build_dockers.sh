
# docker build --rm -t pydemia/centos7-locale-zsh:0.1 -f env-base/dockerfiles/locale_centos7/Dockerfile . 
# docker build --rm -t pydemia/ubuntu1804-locale-zsh:0.1 -f env-base/dockerfiles/locale_ubuntu1804/Dockerfile .

# docker push pydemia/centos7-locale-zsh:0.1
# docker push pydemia/ubuntu1804-locale-zsh:0.1

docker build --rm -t pydemia/jupyter-centos7:0.1 -f env-jupyter/dockerfiles/jupyter_centos7/Dockerfile . 
docker build --rm -t pydemia/jupyter-ubuntu1804:0.1 -f env-jupyter/dockerfiles/jupyter_ubuntu1804/Dockerfile . 

# docker push pydemia/jupyter-centos7:0.1
# docker push pydemia/jupyter-ubuntu1804:0.1
