# Dockerfile
# Use the official Maven image to build the service
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the project and package it
RUN mvn clean package

# Use a Java image for the final container
FROM openjdk:11-jre-slim

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the service on port 8080
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]

