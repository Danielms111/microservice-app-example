# Etapa de build
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

# Etapa de ejecución
FROM openjdk:17-jdk
WORKDIR /app
ENV JWT_SECRET=PRFT
ENV SERVER_PORT=8083
COPY --from=build /app/target/*.jar app.jar
CMD ["java", "--add-opens=java.base/java.lang=ALL-UNNAMED", "-jar", "app.jar"]

