pipeline {
    agent any

    environment {
        IMAGE_NAME = 'myapp'
        IMAGE_TAG = 'latest'
        COMPOSE_FILE = 'docker-compose.yml'  // Asegúrate de que esta variable de entorno esté configurada correctamente
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    echo 'Building Docker images with Docker Compose'
                    // Aquí se usa la ruta literal para evitar posibles problemas con la expansión de la variable
                    sh 'docker-compose -f docker-compose.yml build'
                }
            }
        }

        stage('Run Docker Containers') {
            steps {
                script {
                    echo 'Running Docker containers using Docker Compose'
                    // Asegúrate de que el archivo docker-compose.yml esté bien configurado
                    sh 'docker-compose -f docker-compose.yml up -d'
                }
            }
        }

        stage('Check Logs') {
            steps {
                script {
                    echo 'Checking logs of the Docker container'
                    // Comando para ver los últimos 100 logs
                    sh 'docker-compose logs --tail=100 app'
                }
            }
        }

        stage('Test Docker Containers') {
            steps {
                script {
                    echo 'Running tests on Docker containers'
                    // Aquí puedes verificar el estado de los contenedores si tienen el puerto 8081 expuesto
                    sh 'docker-compose exec app curl http://localhost:8081'
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up Docker containers'
                // Aquí detenemos los contenedores y limpiamos los recursos
                sh 'docker-compose -f docker-compose.yml down'
            }
        }
    }
}
