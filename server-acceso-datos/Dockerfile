FROM openjdk:11

ENV PGPASSFILE /opt/pgpass.conf
ADD pgpass.conf /opt/

WORKDIR /opt/ 

RUN chmod 0600 pgpass.conf
RUN apt-get update && \
    apt-get install postgresql -y

ADD jar/api-acceso-datos.jar /opt/
ADD execute-jar.sh /opt/



COPY wait-for-postgres.sh /opt/
COPY wait-for-discovery.sh /opt/
RUN chmod +x wait-for-postgres.sh
RUN chmod +x wait-for-discovery.sh
RUN chmod +x execute-jar.sh  

ENTRYPOINT  ["sh","/opt/execute-jar.sh"]