# Continuous integration 
***
Proyecto en el cual se encuentran lo necesaria para integracion continua del proyecto para la creacion de articulos de investigacion.  

# Crear contenedor Registry
***
Ejecutamos el siguiente comando para generar el contenedor de registro.
```
docker run -d --name repo-api -p 5000:5000 -v /volumenes/vol_registry:/var/lib/registry registry:latest
```

Permitimos subir imagenes por medio de http  

Creamos o modificamos el siguiente directorio.
```
/etc/docker/daemon.json
```
Adicionamos lo siguiente en el archivo.
```
{ "insecure-registries":["<ip-server>:5000"] }
``` 
Reiniciamos el servicio de docker
```
sudo service docker restart
```
## Volumenes
***
Es necesario ejecutar el siguiente comando, esto con el fin de crear los volumenes necesarios para su funcionamiento.  

```bash
sudo mkdir -p /volumenes/vol_gitlab \
        /volumenes/vol_gitlab/config  /volumenes/vol_gitlab/logs /volumenes/vol_gitlab/data \
        /volumenes/vol_jenkins \
        /volumenes/vol_registry \
        /volumenes/vol_postgresql \
        /volumenes/vol_elasticsearch/data
```

/volumenes/vol_gitlab  
/volumenes/vol_gitlab/config  
/volumenes/vol_gitlab/logs  
/volumenes/vol_gitlab/data

/volumenes/vol_jenkins  

/volumenes/vol_postgresql

### Gitlab
***
La forma de adicionar un repositorio al repositorio local es la siguiente.  

- Adicionamos el repositorio remoto.  
```bash
git remote add <nombre-repositorio-remoto> <url-repositorio-remoto> 
```
- Hacemos push al repositorio añadido 
```
git push <nombre-repositorio-remoto> <branch>
```
### Generar Git hooks
Se requiere ir a la ubicación de los repositorios ruta 

```
/var/opt/gitlab/git-data/repository
```
En el caso que la url no exista ejecuta el siguiente comando y vuelve a buscar la ruta anteriormente mencionada.

```
gitlab-rake gitlab:storage:rollback_to_legacy ID_FROM=1 ID_TO=50
```
Creamos la carpeta custom_hooks dentro del repositorio que deseamos crear el gatillo y dentro de esta creamos el archivo 