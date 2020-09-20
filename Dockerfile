FROM alpine
# Install Java 8 JRE
RUN apk add openjdk8-jre
# Add user and group mc:mc
RUN addgroup -g 470 mc && adduser -D -G mc -u 470 mc
USER mc
RUN mkdir /home/mc/server
WORKDIR /home/mc/server
# Download Minecraft server jar
RUN wget https://launcher.mojang.com/v1/objects/f02f4473dbf152c23d7d484952121db0b36698cb/server.jar
RUN java -jar server.jar
# Agree to EULA
RUN sed -i 's/false/true/' eula.txt
CMD ["java", "-jar", "-XX:InitialRAMPercentage=75.0", "-XX:MaxRAMPercentage=75.0", "-XX:+UseG1GC", "server.jar", "--nogui"]