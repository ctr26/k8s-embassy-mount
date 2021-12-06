FROM python:3.9-slim


# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab

# create user with a home directory
ARG NB_USER
ARG NB_UID

ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}

RUN mkdir /home/${NB_USER}/fg_bioimage
RUN echo '10.35.106.250:/fg_bioimage   /home/${NB_USER}/fg_bioimage    nfs    rw,relatime,user,noauto   0   0' >> /etc/fstab

USER ${USER}
