# Use OpenJDK as the base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the JAR file
COPY target/*.jar app.jar

# Expose application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
