String urlRepoBack  = "https://github.com/jnsierra/api-article.git"

pipeline {
    agent any
    parameters {
        choice(
            choices: ['SI' , 'NO'],
            description: 'Al encontrarse en si el parametro ejecutara el comando para eliminar las imagenes locales previas al despliegue',
            name: 'BORRAR_IMAGENES'
        )
    }

    stages {
        stage('Delete Stack'){
            steps{
                echo 'Ini delete stack'
                script {
                    try {
                        sh 'docker stack rm api-service'
                     } catch (Exception e) {
                      echo 'No fue posible borrar el stack'
                     }
                }
                echo 'Fin delete stack'
            }
        }
        stage('Clone Repo Front and Backend'){
          steps {
            sh 'mkdir -p build-back'
            dir('build-back'){
                    git branch: 'develop', url: urlRepoBack
            }
          }
        }
        stage('Test'){
            steps{
                echo 'Start Testing...'
                sh '''
                     docker run --rm -v /root/.m2:/root/.m2 -v /volumenes/vol_jenkins/workspace/pipeline-job-backend/build-back:/app \
                     -w /app maven:3-openjdk-11 mvn -B test
                   '''
                echo 'Finish Testing...'
            }
        }
        stage('Build'){
            steps{
                
                echo 'Compilando y construyendo el codigo desde maven'
                sh ''' 
                    docker run --rm -v /root/.m2:/root/.m2 \
                                    -v /volumenes/vol_jenkins/workspace/pipeline-job-backend/build-back:/app \
                                    -w /app maven:3-openjdk-11 mvn -B -DskipTests clean package
                   '''
                echo 'Fin Building...' 
            }
        }
        stage('Copy jars'){
          steps{
            echo 'Iniciamos a copiar los artefactos generados'
            sh 'mkdir -p jars'
            sh 'mv build-back/api-acceso-datos/target/api-acceso-datos.jar server-acceso-datos/jar/'
            sh 'mv build-back/api-business/target/api-business.jar server-business/jar/'	
            sh 'mv build-back/api-server-config/target/api-server-config.jar server-config/jar/'
            sh 'mv build-back/api-service-discovery/target/api-service-discovery.jar server-discovery/jar/'
            sh 'mv build-back/api-gateway/target/api-gateway.jar server-gateway/jar/'
            echo 'Finalizamos la copia de los artefactos generados'
          }
        }
        stage('Remove images...'){
             when {
                // Solo ejecuta la eliminacion de imagenes si se envia si
                expression { params.BORRAR_IMAGENES == 'SI' }
            }
            steps{
                script{
                     try {
                        sh 'docker rmi ${IP_REGISTRY}:5000/server-gateway '+ipRegistry+':5000/server-discovery '
                        sh 'docker rmi ${IP_REGISTRY}:5000/server-config '
                        sh 'docker rmi ${IP_REGISTRY}:5000/server-business '
                        sh 'docker rmi ${IP_REGISTRY}:5000/server-acceso-datos '
                        sh 'docker rmi ${IP_REGISTRY}:5000/server-zipkin'
                     } catch (Exception e) {
                      echo 'No fue posible borrar el stack'
                     }
                }
            }
        }
        stage('Tag Images'){
            steps {
                echo 'Ini Tag images...'
                dir('server-acceso-datos'){
                    sh 'docker build -t "${IP_REGISTRY}:5000/server-acceso-datos:latest" .'
                }   
                dir('server-business'){
                    sh 'docker build -t "${IP_REGISTRY}:5000/server-business:latest" .'
                } 
                dir('server-config'){
                    sh 'docker build -t "${IP_REGISTRY}:5000/server-config:latest" .'
                }
                dir('server-discovery'){
                    sh 'docker build -t "${IP_REGISTRY}:5000/server-discovery:latest" .'
                }
                dir('server-gateway'){
                    sh 'docker build -t "${IP_REGISTRY}:5000/server-gateway:latest" .'
                }
                dir('server-zipkin'){
                    sh 'docker build -t "${IP_REGISTRY}:5000/server-zipkin:latest" .'
                }
                echo 'Fin Tag images...'
            }
        }
        stage('Push Images'){
            steps {
                echo 'Ini up images registry'
                sh 'docker push ${IP_REGISTRY}:5000/server-config:latest'
                sh 'docker push ${IP_REGISTRY}:5000/server-business:latest'
                sh 'docker push ${IP_REGISTRY}:5000/server-discovery:latest'
                sh 'docker push ${IP_REGISTRY}:5000/server-gateway:latest'
                sh 'docker push ${IP_REGISTRY}:5000/server-acceso-datos:latest'
                sh 'docker push ${IP_REGISTRY}:5000/server-zipkin:latest'                
                echo 'Fin up images registry'
            }
        }
        stage('deploy stack'){
            steps{
                sh 'docker stack deploy -c docker-compose.yml api-service'
            }
        }
   }
}
