#!/bin/sh
# EULA-Zustimmung aus der Env-Var in die Datei schreiben, die Mojang verlangt
echo "eula=${EULA}" > /data/eula.txt

# exec ersetzt die Shell durch den Java-Prozess -> sauberes Stoppen (Signale!)
exec java -Xms${INIT_MEMORY} -Xmx${MAX_MEMORY} -jar /opt/app/server.jar nogui