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
&& apt install --no-install-recommends -y curl wget ca-certificates lib32gcc-s1 locales \
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

# steam user for download & install
RUN groupadd steam -g ${GROUP_ID} \
&& useradd -g ${GROUP_ID} -u ${USER_ID} -m ${USER}\
&& chown -R ${USER_ID}:${GROUP_ID} ${HOMEDIR} \
&& mkdir -p ${STEAMCMDDIR} \
&& chown -R ${USER_ID}:${GROUP_ID} ${STEAMCMDDIR} \
&& mkdir -p ${GAMEDIR} \
&& chown -R ${USER_ID}:${GROUP_ID} ${GAMEDIR} \
&& mkdir -p ${HOMEDIR}/.config/Epic/FactoryGame/Saved/SaveGames \
&& mkdir -p ${HOMEDIR}/.steam/sdk64 \
&& chown -R ${USER_ID}:${GROUP_ID} ${HOMEDIR}/.config/Epic/FactoryGame/Saved/SaveGames \
&& ln -s ${STEAMCMDDIR}/linux64/steamclient.so ${HOMEDIR}/.steam/sdk64/steamclient.so
#USER ${USER_ID}:${GROUP_ID}
WORKDIR ${STEAMCMDDIR}
RUN wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
&& tar -xvf steamcmd_linux.tar.gz \
&& rm -f steamcmd_linux.tar.gz \
&& ./steamcmd.sh +quit
COPY --chown=${USER_ID}:${GROUP_ID} start.sh ${HOMEDIR}/start.sh
EXPOSE 15777/UDP 7777/UDP 15000/UDP
CMD /bin/sh ${HOMEDIR}/start.sh

