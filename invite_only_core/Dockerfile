## Use the official maven/Java 8 image to create a build artifact.
## https://hub.docker.com/_/maven
FROM maven:3-jdk-8-slim AS build-env

# Set the working directory to /app
WORKDIR /app
# Copy the pom.xml file to download dependencies
COPY pom.xml ./
# Copy local code to the container image.
COPY src ./src

# Download dependencies and build a release artifact.
RUN mvn package -DskipTests

# Use AdoptOpenJDK for base image.
# It's important to use OpenJDK 8u191 or above that has container support enabled.
# https://hub.docker.com/r/adoptopenjdk/openjdk8
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM adoptopenjdk/openjdk8:alpine-slim

# Copy the jar to the production image from the builder stage.
COPY --from=build-env /target/invite_only_core-*.jar /invite_only_core.jar

# Copy the google service account key file to the production image.
COPY /service-account-key.json /service-account-key.json

# Set the GOOGLE_APPLICATION_CREDENTIALS environment var
ENV GOOGLE_APPLICATION_CREDENTIALS service-account-key.json

# Run the web service on container startup.
CMD ["java", "-jar", "/invite_only_core.jar"]
