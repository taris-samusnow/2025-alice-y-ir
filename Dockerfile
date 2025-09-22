FROM node:22 as base-node

ARG HTTP_PROXY
ARG HTTPS_PROXY

ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
	&& apt-get install -y curl git sudo locales \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/* \
    && locale-gen ja_JP.UTF-8 \
    && localedef -f UTF-8 -i ja_JP ja_JP.utf8

FROM base-node as base-user-node

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG USER
ARG GROUPNAME

RUN gpasswd -a ${USER} sudo \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER}

USER ${USER}

WORKDIR /home/${USER}

FROM base-user-node as dev-user-node

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG USER
ARG GROUPNAME
ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0

USER ${USER}

COPY app /home/${USER}/app

RUN sudo chown ${USER}:${GROUPNAME} -R /home/${USER}/app \
      && sudo corepack enable yarn

WORKDIR /home/${USER}/app

FROM dev-user-node as serv-user-node

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG USER
ARG GROUPNAME

USER ${USER}

RUN sudo chown ${USER}:${GROUPNAME} -R /home/${USER}/app

RUN  yarn install \ 
     && yarn build

ENTRYPOINT ["/bin/bash", "-c", "yarn preview --host 0.0.0.0 --port 3000"]