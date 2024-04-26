FROM mcr.microsoft.com/devcontainers/base:ubuntu
# Install tar and gzip to extract the Maven binaries
ARG USER_HOME_DIR="/root"
#ARG MAVEN_DOWNLOAD_URL=https://nexus.conseqta.io/repository/conseqta-cache/apache-maven/apache-maven-3.9.4-bin.tar.gz

RUN apt-get update && apt-get install -y curl zip unzip

#install SDK man
RUN curl -s "https://get.sdkman.io" | bash

# this SHELL command is needed to allow using source
SHELL ["/bin/bash", "-c"]    

RUN source "$HOME/.sdkman/bin/sdkman-init.sh" \
    && sdk install java 22-graal -y \
    && sdk install maven

# RUN mkdir -p /usr/share/maven /usr/share/maven/ref 
# #RUN curl -fsSL -o /tmp/apache-maven.tar.gz ${MAVEN_DOWNLOAD_URL} 
# COPY apache-maven-3.9.4-bin.tar.gz /tmp/apache-maven.tar.gz 

# RUN tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 
# RUN rm -f /tmp/apache-maven.tar.gz 
# RUN ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV JAVA_HOME $HOME/.sdkman/candidates/java/current/
#COPY ./.m2/settings.xml $USER_HOME_DIR/.m2
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"