FROM openjdk:11-jdk-slim

# Configurar el directorio de trabajo
WORKDIR /app

# Instalar curl
RUN apt-get update && apt-get install -y curl && apt-get clean

# Copiar la aplicación
COPY target/myapp-1.0-SNAPSHOT.jar /app/myapp.jar

# Comando de inicio
CMD ["java", "-jar", "/app/myapp.jar"]
