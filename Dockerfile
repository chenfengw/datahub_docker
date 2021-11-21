# 1) choose base container
# scipy/machine learning (tensorflow, pytorch)
# https://hub.docker.com/repository/docker/ucsdets/scipy-ml-notebook/tags
FROM ucsdets/scipy-ml-notebook:2021.3-42158c8

# 2) change to root to install packages
USER root
RUN apt-get update && apt-get install -y htop libglfw3 libglew2.0 libglew-dev libgl1-mesa-glx libosmesa6 git

# install mujoco
ADD https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz ./
RUN tar -xvzf mujoco210-linux-x86_64.tar.gz && rm -rf mujoco210-linux-x86_64.tar.gz
RUN mkdir -p ~/.mujoco && mv ./mujoco210 ~/.mujoco/mujoco210

# 3) install packages for python
COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt && rm requirements.txt

# set up jupyter stuff

# set enviroment variable
ENV MUJOCO_GL egl
