FROM openjdk:11
ADD jar/zipkin-server-2.23.2-exec.jar /opt/zipkin-server.jar
WORKDIR /opt/
ENTRYPOINT  ["java", "-jar","/opt/zipkin-server.jar"]