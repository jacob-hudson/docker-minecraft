ENV MINECRAFT_VERSION 1.13

RUN apt-get update && apt-get install -y default-jre-headless && apt-get install -y net-tools

RUN useradd -m -d /minecraft minecraft

ADD https://s3.amazonaws.com/Minecraft.Download/versions/${MINECRAFT_VERSION}/minecraft_server.${MINECRAFT_VERSION}.jar /minecraft/minecraft_server.jar

RUN echo "eula=true" > minecraft/eula.txt

RUN echo "[]" > minecraft/banned-players.json
RUN echo "[]" > minecraft/banned-ips.json
RUN echo "[]" > minecraft/whitelist.json
RUN echo "[]" > minecraft/ops.json

ADD assets/server.properties minecraft/server.properties

RUN chown minecraft:minecraft /minecraft/*

VOLUME /minecraft
WORKDIR /minecraft
EXPOSE 25565
USER minecraft

ENTRYPOINT ["java", "-jar", "-Xmx1024M", "-Xms1024M", "minecraft_server.jar", "nogui"]
