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
                    bat 'docker-compose -f %COMPOSE_FILE% build'
                }
            }
        }

        stage('Run Docker Containers') {
            steps {
                script {
                    echo 'Running Docker containers using Docker Compose'
                    bat 'docker-compose -f %COMPOSE_FILE% up -d'
                }
            }
        }

        stage('Check Logs') {
            steps {
                script {
                    echo 'Checking logs of the Docker container'
                    bat 'docker-compose logs --tail=100 app'
                }
            }
        }

        stage('Test Docker Containers') {
            steps {
                script {
                    echo 'Running tests on Docker containers'
                    bat 'docker-compose exec app curl http://localhost:8081'
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up Docker containers'
                bat 'docker-compose -f %COMPOSE_FILE% down'
            }
        }
    }
}
