pipeline {
    agent any

    environment {
        IMAGE_NAME = 'myapp'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    echo "Running Docker container ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh 'docker run -d -p 8081:8081 --name myapp-container ${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }

        stage('Test Docker Container') {
            steps {
                script {
                    echo "Running tests on Docker container"
                    sh 'curl --fail http://localhost:8081 || exit 1'
                }
            }
        }
    }

    post {
        always {
            script {
                echo "Cleaning up Docker container"
                sh 'docker stop myapp-container || true'
                sh 'docker rm myapp-container || true'
            }
        }
    }
}
