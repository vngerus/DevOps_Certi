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
                    sh 'docker-compose -f $COMPOSE_FILE up -d'  // Sin 'nohup', ejecuta en segundo plano con -d
                }
            }
        }

        stage('Test Docker Containers') {
            steps {
                script {
                    echo 'Running tests on Docker containers'
                    // Aquí el comando ejecuta curl dentro del contenedor
                    sh 'docker-compose exec app curl http://localhost:8081'  // Ajusta si es necesario
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
