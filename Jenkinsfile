pipeline {
    agent any  // Esto indica que Jenkins puede ejecutar este pipeline en cualquier agente disponible

    environment {
        // Definimos algunas variables de entorno, como el nombre de la imagen
        IMAGE_NAME = 'myapp'
        IMAGE_TAG = 'latest'
    }

    stages {
        // Etapa para construir la imagen Docker
        stage('Build Docker Image') {
            steps {
                script {
                    // Construir la imagen Docker
                    echo "Building Docker image ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                }
            }
        }

        // Etapa para ejecutar el contenedor
        stage('Run Docker Container') {
            steps {
                script {
                    // Ejecutar el contenedor
                    echo "Running Docker container ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh 'docker run -d -p 8081:8081 --name myapp-container ${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }

        // Etapa para probar el contenedor (opcional)
        stage('Test Docker Container') {
            steps {
                script {
                    // Aquí podrías agregar pruebas para verificar que el contenedor está funcionando
                    echo "Running tests on Docker container"
                    sh 'curl http://localhost:8081' // Realizar una solicitud al contenedor
                }
            }
        }
    }

    post {
        // Etapa de limpieza al final del pipeline (detener y eliminar el contenedor)
        always {
            script {
                echo "Cleaning up Docker container"
                sh 'docker stop myapp-container || true'
                sh 'docker rm myapp-container || true'
            }
        }
    }
}
