#!/bin/bash
#wait-for-discovery.sh

host="$1"
status_code="500"

while [ "$status_code" != "200" ]; do

    url=http://"$host":1111/actuator
    echo Url a testear  "$url"
    status_code=$(timeout 2s curl --write-out %{http_code} --silent --output /opt/salida "$url" )

    if [ "$status_code" != "200" ]; then
       echo "Servicio de descubrimiento no disponible" > /opt/validacionFallida
       echo "Servicio de descubrimiento no disponible" 
    fi
    sleep 3
done

echo "Servicio de descubrimiento disponible" > /opt/validacionExitosa
echo "Servicio de descubrimiento disponible" 