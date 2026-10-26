# syntax=docker/dockerfile:1

FROM eclipse-temurin:25-jre

# Build time: download the vanilla server JAR from Mojang into the image.
# To change the Minecraft version, replace this URL with the current server
# download link from https://www.minecraft.net/en-us/download/server
ADD https://piston-data.mojang.com/v1/objects/823e2250d24b3ddac457a60c92a6a941943fcd6a/server.jar /opt/app/server.jar

COPY entrypoint.sh /opt/app/entrypoint.sh
COPY server.properties.example /opt/app/server.properties.template

RUN chmod +x /opt/app/entrypoint.sh

# envsubst (from gettext-base) renders the server.properties template at startup
RUN apt-get update && apt-get install -y --no-install-recommends gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Built-in defaults so the server can always start.
# EULA deliberately defaults to false: accepting it is an explicit
# operator decision, made in the local .env file.
ENV EULA=false \
    INIT_MEMORY=1G \
    MAX_MEMORY=2G \
    MOTD="A Minecraft Server" \
    DIFFICULTY=easy \
    GAMEMODE=survival \
    MAX_PLAYERS=20

# The server writes world and config files into its working directory ->
# set it to /data so everything ends up in the mounted volume.
WORKDIR /data

EXPOSE 25565
ENTRYPOINT ["/opt/app/entrypoint.sh"]