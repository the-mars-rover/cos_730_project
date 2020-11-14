## Use the official maven/Java 8 image to create a build artifact.
## https://hub.docker.com/_/maven
FROM maven:3-jdk-13-slim AS build-env

# Set the working directory to /app
WORKDIR /app
# Copy the pom.xml file to download dependencies
COPY pom.xml ./
# Copy local code to the container image.
COPY src ./src

# Download dependencies and build a release artifact.
RUN mvn package

# Use AdoptOpenJDK for base image.
# It's important to use OpenJDK 8u191 or above that has container support enabled.
# https://hub.docker.com/r/adoptopenjdk/openjdk8
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM adoptopenjdk/openjdk13:alpine-slim

# Copy the jar to the production image from the builder stage.
COPY --from=build-env /app/target/invite_only_core-*.jar /invite_only_core.jar

# Run the web service on container startup.
CMD ["java", "-jar", "/invite_only_core.jar"]
