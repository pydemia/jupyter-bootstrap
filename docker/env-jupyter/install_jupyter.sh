#!/bin/bash

bash -i -c "pip install ipython jupyter \
&& conda install \
nb_conda \
jupyter_contrib_nbextensions \
ipykernel \
ipywidgets \
ipyparallel -y \
&& conda install -c conda-forge nb_conda_kernels -y \
&& pip install jupyter_tensorboard"

# Install Default Python Kernel
bash -i \
./env-jupyter/install_kernel_python.sh \
--kernel_name=py36 \
--display_name="Py3.6" \
--python_version=3.6

# Install Binary: Julia, Scala
bash -i ./env-jupyter/install_other_langs.sh

# Install R Kernel
bash -i \
./env-jupyter/install_kernel_r.sh \
--display_name="R (conda)"

# Install Julia Kernel
bash -i \
./env-jupyter/install_kernel_julia.sh \

# Install Scala Kernel
bash -i \
./env-jupyter/install_kernel_scala.sh \
--kernel_name=scala212 \
--display_name="Scala 2.12.8" \
--scala_version=2.12.8 \
--almond_version=0.6.0 
