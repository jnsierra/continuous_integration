FROM openjdk:11
ADD jar/api-server-config.jar /opt/
ADD execute-jar.sh /opt/
WORKDIR /opt/
#ENV PROFILE_JAR test
WORKDIR /opt/
#USER root
RUN chmod +x execute-jar.sh  
ENTRYPOINT  ["sh","/opt/execute-jar.sh"]