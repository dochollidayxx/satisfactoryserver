FROM ubuntu:latest
LABEL maintainer="adamho"

# preset ids for groupadd and useradd cmds
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG HOMEDIR="/home/steam"
ARG STEAMCMDDIR="${HOMEDIR}/steamcmd"

# handle locale warning (WARNING: setlocale('en_US.UTF-8'))

RUN apt update \
&& apt install -y curl lib32gcc-s1 locales \
&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
&& apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
RUN groupadd steam -g ${GROUP_ID}
RUN useradd -g ${GROUP_ID} -u ${USER_ID} -m steam -d ${HOMEDIR}
USER steam
WORKDIR /home/steam/steamcmd
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - \
&& rm -f steamcmd_linux.tar.gz
RUN ./steamcmd.sh +force_install_dir ~/SatisfactoryDedicatedServer +login anonymous +app_update 1690800 validate +quit
RUN chown -R ${USER_ID}:${GROUP_ID} /home/steam/SatisfactoryDedicatedServer \
&& mkdir -p /home/steam/.config/Epic/FactoryGame/Saved/SaveGames \
&& mkdir -p /home/steam/.steam/sdk64 \
&& chown -R ${USER_ID}:${GROUP_ID} /home/steam/.config/Epic/FactoryGame/Saved/SaveGames
RUN ln -s /home/steam/steamcmd/linux64/steamclient.so /home/steam/.steam/sdk64/steamclient.so
EXPOSE 15777/UDP 7777/UDP 15000/UDP
CMD ["/home/steam/SatisfactoryDedicatedServer/FactoryServer.sh"]

