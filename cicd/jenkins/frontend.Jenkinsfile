String urlRepoFront = "https://github.com/jnsierra/articulos-web.git"
String ipRegistry = "192.168.0.30"

pipeline {
    agent any
    stages {
        stage('Stop Container'){
          steps {
            script {
                try {
                    sh 'docker stop frontend-art'
                    sh 'docker rm frontend-art'
                 } catch (Exception e) {
                  echo 'No fue posible borrar el contenedor de frontend'
                 }
            }
          }
        }
        stage('Clone Repo Front'){
          steps {
            sh 'mkdir -p build-front'
            dir('build-front'){
                    git branch: 'master', url: urlRepoFront
            }
          }
        }
        stage('Build-front'){
            steps{
                dir('build-front'){
                    sh 'docker build -t "${IP_REGISTRY}:5000/angular-cli:latest" .'
                }
            }
        }
        stage('Run Docker'){
            steps{
                sh '''
                    docker run -d -p 5010:80 \
                               --name frontend-art \
                               ${IP_REGISTRY}:5000/angular-cli:latest
                '''
            }
        }
    }
}