# 1) choose base container
FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-devel

# 2) change to root to install packages
USER root
RUN apt-get update && apt-get install -y htop libglfw3 libglew2.0 libglew-dev libgl1-mesa-glx libosmesa6 git

# install mujoco
ADD https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz ./
RUN tar -xvzf mujoco210-linux-x86_64.tar.gz && rm -rf mujoco210-linux-x86_64.tar.gz
RUN mkdir -p ~/.mujoco && mv ./mujoco210 ~/.mujoco/mujoco210

# 3) install packages for python
COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# set enviroment variable
ENV MUJOCO_GL egl
