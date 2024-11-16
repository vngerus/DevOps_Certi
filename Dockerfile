FROM openjdk:11-jdk-slim
WORKDIR /app
COPY target/myapp-1.0-SNAPSHOT.jar /app/myapp.jar
ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]
