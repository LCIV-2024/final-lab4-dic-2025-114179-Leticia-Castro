
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copiamos pom y descargamos dependencias
COPY pom.xml .
RUN mvn dependency:go-offline

# Copiamos el código
COPY src ./src

# Compilamos
RUN mvn clean package -DskipTests


FROM eclipse-temurin:17-jre

WORKDIR /app


COPY --from=build /app/target/*.jar app.jar


EXPOSE 8080


ENTRYPOINT ["java", "-jar", "app.jar"]


