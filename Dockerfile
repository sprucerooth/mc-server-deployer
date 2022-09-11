FROM adoptopenjdk/openjdk16:alpine
RUN apk add jq screen
# Add user and group mc:mc
RUN addgroup -g 470 mc && adduser -D -G mc -u 470 mc
USER mc
RUN mkdir /home/mc/server
WORKDIR /home/mc/server
COPY start.sh start.sh
COPY pull-mc/download-mc.sh download-mc.sh
# Download Minecraft server jar
RUN ./download-mc.sh latest
RUN java -jar server*.jar
# Agree to EULA
RUN sed -i 's/false/true/' eula.txt
# Create directory for volume before creating the volume. Otherwise volume will be owned by root
RUN mkdir /home/mc/server/world
# Create volume to persist world data on container close
VOLUME /home/mc/server/world
CMD ["/bin/sh", "start.sh"]
