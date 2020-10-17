FROM alpine
# Install Java 8 JRE
RUN apk add openjdk8-jre screen
# Add user and group mc:mc
RUN addgroup -g 470 mc && adduser -D -G mc -u 470 mc
USER mc
RUN mkdir /home/mc/server
WORKDIR /home/mc/server
COPY start.sh start.sh
# Download Minecraft server jar
RUN wget https://launcher.mojang.com/v1/objects/f02f4473dbf152c23d7d484952121db0b36698cb/server.jar
RUN java -jar server.jar
# Agree to EULA
RUN sed -i 's/false/true/' eula.txt
# Create directory for volume before creating the volume. Otherwise volume will be owned by root
RUN mkdir /home/mc/server/world
# Create volume to persist world data on container close
VOLUME /home/mc/server/world
CMD ["/bin/sh", "start.sh"]
