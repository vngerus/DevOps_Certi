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
                    bat 'docker-compose -f %COMPOSE_FILE% build --no-cache'
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

        stage('Verify Container Status') {
            steps {
                script {
                    echo 'Checking if container is running...'
                    bat 'docker-compose ps'
                }
            }
        }

        stage('Wait for Container to Start') {
            steps {
                script {
                    bat '''
                        echo Waiting for container to start...
                        for /l %%x in (1, 1, 10) do (
                            docker-compose ps | findstr "app" && exit /b 0
                            timeout /t 2
                        )
                        exit /b 1
                    '''
                }
            }
        }

        stage('Check Logs') {
            steps {
                script {
                    echo 'Checking logs of the Docker container'
                    bat 'docker-compose logs app'
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
