pipeline {
    agent any 

    environment {
        // Variables de entorno para los servicios y el nombre de la imagen
        IMAGE_NAME = 'myapp'
        IMAGE_TAG = 'latest'
        COMPOSE_FILE = 'docker-compose.yml'  // Asegúrate de tener el archivo docker-compose.yml
    }

    stages {
        // Etapa para construir los servicios definidos en docker-compose.yml
        stage('Build Docker Images') {
            steps {
                script {
                    echo "Building Docker images with Docker Compose"
                    sh 'docker-compose -f $COMPOSE_FILE build'
                }
            }
        }

        // Etapa para iniciar los contenedores con docker-compose
        stage('Run Docker Containers') {
            steps {
                script {
                    echo "Running Docker containers using Docker Compose"
                    sh 'docker-compose -f $COMPOSE_FILE up -d'  // Inicia los contenedores en segundo plano
                }
            }
        }

        // Etapa para realizar pruebas en los contenedores (opcional)
        stage('Test Docker Containers') {
            steps {
                script {
                    echo "Running tests on Docker container"
                    sh 'docker-compose -f $COMPOSE_FILE exec myapp-container curl http://localhost:8081' // O lo que necesites
                }
            }
        }
    }

    post {
        // Etapa de limpieza para detener y eliminar los contenedores
        always {
            script {
                echo "Cleaning up Docker containers"
                sh 'docker-compose -f $COMPOSE_FILE down'  // Detiene y elimina los contenedores y redes
            }
        }
    }
}
