screen -dmS mc java -jar -XX:InitialRAMPercentage=75.0 -XX:MaxRAMPercentage=75.0 -XX:+UseG1GC server.jar --nogui
tail -f logs/latest.log
