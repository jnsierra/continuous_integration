String urlRepoFront = "https://github.com/jnsierra/articulos-web.git"

pipeline {
    agent any
    stages {
        stage('Clone Repo Front'){
          steps {
            sh 'mkdir -p build-front'
            dir('build-front'){
                    git branch: 'master', url: urlRepoFront
            }
          }
        }
        stage('Remove container'){
            steps{
                echo "Funciona " + urlRepoFront
            }
        }
    }
}