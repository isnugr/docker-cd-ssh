# Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-cd-ssh> for details.

FROM debian:stable-slim

LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"

ENV FRX_VARS_DEBUG= \
    FRX_VARS_PREFIX= \
    SSH_PRIVATE_KEY= \
    SSH_KNOWN_HOSTS= \
    SSH_USER= \
    SSH_PASS= \
    SSH_HOST= \
    SSH_PORT= \
    SSH_OPTIONS=

COPY ./build ./Dockerfile ./LICENSE ./README.md  /frx/

RUN /frx/build