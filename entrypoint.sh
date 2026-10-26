#!/bin/sh
# Write the EULA acceptance from the env var into the file Mojang requires
echo "eula=${EULA}" > /data/eula.txt

# Render the gameplay config from the template using the container environment
envsubst < /opt/app/server.properties.template > /data/server.properties

# exec replaces the shell with the Java process -> clean shutdown (signals!)
exec java -Xms${INIT_MEMORY} -Xmx${MAX_MEMORY} -jar /opt/app/server.jar nogui