FROM openjdk:11-jdk-slim

# Copia el archivo JAR generado por Maven
COPY target/myapp-1.0-SNAPSHOT.jar /app/myapp.jar

# Expone el puerto de la aplicación
EXPOSE 8081

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]
