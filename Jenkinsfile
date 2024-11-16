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
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'  // Asegúrate de que tu Dockerfile esté en el directorio actual
                }
            }
        }

        // Etapa para ejecutar el contenedor
        stage('Run Docker Container') {
            steps {
                script {
                    // Ejecutar el contenedor
                    echo "Running Docker container ${IMAGE_NAME}:${IMAGE_TAG}"
                    // Exponemos el puerto 8081 del contenedor al puerto 8081 de la máquina host
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
                    // Realizar una solicitud al contenedor
                    sh 'curl --fail http://localhost:8081 || exit 1'  // Si el contenedor no responde, fallará el pipeline
                }
            }
        }
    }

    post {
        // Etapa de limpieza al final del pipeline (detener y eliminar el contenedor)
        always {
            script {
                echo "Cleaning up Docker container"
                // Detener y eliminar el contenedor, si existe
                sh 'docker stop myapp-container || true'  // Si no existe el contenedor, no fallará
                sh 'docker rm myapp-container || true'    // Igualmente, si no existe, no fallará
            }
        }
    }
}
