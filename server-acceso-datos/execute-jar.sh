sh wait-for-postgres.sh $SERVER_BD
sh wait-for-discovery.sh $SERVER_DISCOVERY
java -jar -Dspring.profiles.active=$PROFILE_JAR api-acceso-datos.jar 