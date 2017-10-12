FROM gradle:jdk8-alpine

MAINTAINER Raymond Wen "rx.wen218@gmail.com"

ENV ANDROID_SDK_VERSION 3859397

RUN whoami
USER root
RUN whoami
RUN apk update && apk add -f unzip curl wget openssl make

# Install Android SDK
ENV ANDROID_HOME /opt/android-sdk
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
        && mkdir ${ANDROID_HOME} \
        && unzip -C ${ANDROID_HOME} sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
        && rm sdk-tools-linux-${ANDROID_SDK_VERSION}.zip

# Setup environment
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools/bin;
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo

# Install sdk components
RUN yes | sdkmanager --licenses
RUN sdkmanager --list --verbose
RUN sdkmanager --update --verbose

