FROM openjdk:17.0.1-jdk-slim

WORKDIR /app

COPY . .

RUN chmod +x gradlew && ./gradlew build --no-daemon

FROM tomcat:9

COPY build/libs/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose cổng 8080
EXPOSE 8080


