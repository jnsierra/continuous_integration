sh wait-for-discovery.sh $SERVER_DISCOVERY
java -jar -Dspring.profiles.active=$PROFILE_JAR api-gateway.jar 