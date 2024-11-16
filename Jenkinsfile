pipeline {
    agent any

    environment {
        IMAGE_NAME = 'myapp'
        IMAGE_TAG = 'latest'
        COMPOSE_FILE = 'docker-compose.yml'
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
                    sh 'docker-compose -f $COMPOSE_FILE build'
                }
            }
        }

        stage('Run Docker Containers') {
            steps {
                script {
                    echo 'Running Docker containers using Docker Compose'
                    sh 'docker-compose -f $COMPOSE_FILE up -d'  // -d para ejecutarlo en segundo plano
                }
            }
        }

        stage('Test Docker Containers') {
            steps {
                script {
                    echo 'Running tests on Docker containers'
                    // Pruebas para verificar que el servicio está funcionando
                    sh 'docker-compose exec app curl http://localhost:8081' // Cambia si el servicio tiene otro nombre o puerto
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up Docker containers'
                sh 'docker-compose -f $COMPOSE_FILE down'
            }
        }
    }
}
