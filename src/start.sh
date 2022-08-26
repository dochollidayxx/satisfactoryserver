# !/bin/bash
chown -R $PUID:$GUID /home/steam/.config
exec gosu $PUID:$GUID "$GAMEDIR/FactoryServer.sh" "$@"