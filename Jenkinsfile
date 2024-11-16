pipeline {
    agent any

    environment {
        IMAGE_NAME = 'myapp'                  // Nombre de la imagen Docker
        IMAGE_TAG = 'latest'                  // Etiqueta para la imagen Docker
        COMPOSE_FILE = 'docker-compose.yml'   // Archivo docker-compose a usar
        DOCKER_BUILDKIT = '0'                 // Deshabilitar BuildKit para evitar problemas de compatibilidad
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Descarga el código fuente desde el repositorio
                checkout scm
            }
        }

        stage('Clean Docker Environment') {
            steps {
                script {
                    echo 'Cleaning Docker environment'
                    // Limpia contenedores, imágenes, volúmenes y redes antiguas
                    bat '''
                        docker-compose down --rmi all --volumes --remove-orphans
                        docker system prune -a --volumes -f
                    '''
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    echo 'Building Docker images with Docker Compose'
                    // Construye las imágenes Docker sin usar caché
                    bat 'docker-compose -f %COMPOSE_FILE% build --no-cache'
                }
            }
        }

        stage('Run Docker Containers') {
            steps {
                script {
                    echo 'Running Docker containers using Docker Compose'
                    // Levanta los contenedores definidos en el archivo docker-compose
                    bat 'docker-compose -f %COMPOSE_FILE% up -d'
                }
            }
        }

        stage('Check Logs') {
            steps {
                script {
                    echo 'Checking logs of the Docker container'
                    // Muestra los logs del contenedor "app"
                    bat 'docker-compose logs app'
                }
            }
        }

        stage('Test Docker Containers') {
            steps {
                script {
                    echo 'Running tests on Docker containers'
                    // Verifica que el contenedor esté funcionando con una solicitud HTTP
                    bat 'docker-compose exec app curl http://localhost:8081'
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up Docker containers'
                // Limpia los contenedores y recursos creados durante el pipeline
                bat 'docker-compose -f %COMPOSE_FILE% down'
            }
        }
    }
}
