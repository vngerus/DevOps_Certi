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
                    // Usar PowerShell para ejecutar docker-compose
                    powershell 'docker-compose -f $env.COMPOSE_FILE up --build -d'
                }
            }
        }

        stage('Run Docker Containers') {
            steps {
                script {
                    echo 'Running Docker containers using Docker Compose'
                    // Usar PowerShell para ejecutar docker-compose
                    powershell 'docker-compose -f $env.COMPOSE_FILE up -d'
                }
            }
        }

        stage('Test Docker Containers') {
            steps {
                script {
                    echo 'Running tests on Docker containers'
                    // Ejecutar pruebas o comandos dentro de los contenedores
                    powershell 'docker-compose exec myapp-container curl http://localhost:8081' // Ajusta el contenedor y puerto
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up Docker containers'
                powershell 'docker-compose -f $env.COMPOSE_FILE down'
            }
        }
    }
}
