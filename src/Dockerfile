FROM ubuntu:latest
LABEL maintainer="adamho"

# preset ids for groupadd and useradd cmds
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USER="steam"
ARG HOMEDIR="/home/${USER}"
ARG STEAMCMDDIR="${HOMEDIR}/steamcmd"
ARG GAMEDIR="${HOMEDIR}/SatisfactoryDedicatedServer"

# necessary packages and install steps
RUN apt update \
    && apt install --no-install-recommends -y curl gosu wget ca-certificates lib32gcc-s1 locales \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# env variables
ENV LANG=en_US.utf8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV HOMEDIR=${HOMEDIR}
ENV GAMEDIR=${GAMEDIR}
ENV STEAMCMDDIR=${STEAMCMDDIR}
ENV PUID=${USER_ID}
ENV GUID=${GROUP_ID}

# steam user for download & install
RUN groupadd steam -g ${GROUP_ID} \
    && useradd -g ${GROUP_ID} -u ${USER_ID} -m ${USER}\
    && su ${USER} -c \
    "mkdir -p \"${STEAMCMDDIR}\" \
    && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C \"${STEAMCMDDIR}\" \
    && \"./${STEAMCMDDIR}/steamcmd.sh\" +quit \
    && mkdir -p \"${HOMEDIR}/.steam/sdk32\" \
    && ln -s \"${STEAMCMDDIR}/linux32/steamclient.so\" \"${HOMEDIR}/.steam/sdk32/steamclient.so\" \
    && ln -s \"${STEAMCMDDIR}/linux32/steamcmd\" \"${STEAMCMDDIR}/linux32/steam\" \
    && ln -s \"${STEAMCMDDIR}/steamcmd.sh\" \"${STEAMCMDDIR}/steam.sh\"" \
    && ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" \
    && apt-get remove --purge --auto-remove -y \
    wget \
	&& rm -rf /var/lib/apt/lists/*
WORKDIR ${STEAMCMDDIR}
RUN ${STEAMCMDDIR}/steamcmd.sh +force_install_dir $GAMEDIR +login anonymous +app_update 1690800 validate +quit
COPY --chown=${USER_ID}:${GROUP_ID} start.sh ${HOMEDIR}/start.sh
EXPOSE 15777/UDP 7777/UDP 15000/UDP
CMD /bin/sh ${HOMEDIR}/start.sh
