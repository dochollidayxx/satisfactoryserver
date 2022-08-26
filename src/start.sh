# !/bin/bash
echo "Installing Satisfactory in location: $GAMEDIR"
$STEAMCMDDIR/steamcmd.sh +force_install_dir $GAMEDIR +login anonymous +app_update 1690800 validate +quit
$GAMEDIR/FactoryServer.sh