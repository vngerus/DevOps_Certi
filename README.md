
# Pipeline CI/CD con Jenkins, Docker y Docker Compose

## Descripción

Este proyecto implementa un pipeline CI/CD utilizando **Jenkins**, **Docker**, y **Docker Compose** para construir, probar y desplegar una aplicación. El pipeline automatiza las tareas críticas de desarrollo y despliegue, garantizando consistencia y eficiencia.

---

## Índice

1. [Estructura del Proyecto](#estructura-del-proyecto)
2. [Pipeline (Jenkinsfile)](#pipeline-jenkinsfile)
3. [Dockerfile](#dockerfile)
4. [Instrucciones para Configurar Jenkins](#instrucciones-para-configurar-jenkins)
5. [Comandos Útiles](#comandos-útiles)
6. [Conclusión](#conclusión)

---

## Estructura del Proyecto

```plaintext
.
├── Jenkinsfile          # Definición del pipeline en Jenkins
├── Dockerfile           # Configuración para construir la imagen Docker
├── docker-compose.yml   # Orquestación de contenedores Docker
├── README.md            # Documentación del proyecto
└── src/                 # Código fuente de la aplicación
```

---

## Pipeline (Jenkinsfile)

El archivo `Jenkinsfile` define el pipeline y sus etapas. Aquí está el código completo:

```groovy
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'myapp'
        IMAGE_TAG = 'latest'
        COMPOSE_FILE = 'docker-compose.yml'
        DOCKER_BUILDKIT = '0' // Desactiva BuildKit por compatibilidad
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Clona el repositorio del código fuente
                checkout scm
            }
        }

        stage('Clean Docker Environment') {
            steps {
                script {
                    echo 'Cleaning Docker environment'
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
```

---

## Dockerfile

El `Dockerfile` define cómo construir la imagen de la aplicación:

```dockerfile
# Usa una imagen base de Java
FROM openjdk:11-jdk-slim

# Define el directorio de trabajo
WORKDIR /app

# Copia el archivo JAR compilado al contenedor
COPY target/myapp-1.0-SNAPSHOT.jar /app/myapp.jar

# Define el comando de inicio de la aplicación
ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]

# Expone el puerto en el que la aplicación estará escuchando
EXPOSE 8081
```

---

## Instrucciones para Configurar Jenkins

1. **Instalar Plugins Requeridos**:
   - Docker Pipeline
   - Git
   - Declarative Pipeline

2. **Configurar el Agente Jenkins**:
   - Asegúrate de que Jenkins puede ejecutar comandos de Docker.
   - Añade el usuario de Jenkins al grupo de Docker si es necesario:
     ```bash
     sudo usermod -aG docker jenkins
     sudo systemctl restart docker
     sudo systemctl restart jenkins
     ```

3. **Pipeline Multibranch**:
   - Crea un nuevo proyecto en Jenkins como **Pipeline Multibranch**.
   - Configura el repositorio Git donde se encuentra el `Jenkinsfile`.

---

## Comandos Útiles

### Docker
- **Construir la imagen**:
  ```bash
  docker-compose build --no-cache
  ```
- **Iniciar los contenedores**:
  ```bash
  docker-compose up -d
  ```
- **Verificar logs**:
  ```bash
  docker-compose logs app
  ```
- **Eliminar contenedores, imágenes y volúmenes**:
  ```bash
  docker-compose down --rmi all --volumes --remove-orphans
  ```

---

## Conclusión

Este proyecto implementa un pipeline robusto y flexible para gestionar el ciclo de vida de desarrollo y despliegue de la aplicación. El uso de herramientas modernas como Jenkins y Docker Compose garantiza un entorno reproducible y confiable.
