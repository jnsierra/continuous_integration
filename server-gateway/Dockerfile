FROM openjdk:11
ADD jar/api-gateway.jar /opt/
ADD wait-for-discovery.sh /opt/
ADD execute-jar.sh /opt/
WORKDIR /opt/
#USER root
RUN chmod +x execute-jar.sh  
RUN chmod +x wait-for-discovery.sh
ENTRYPOINT  ["sh","/opt/execute-jar.sh"]