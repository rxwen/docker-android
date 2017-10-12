FROM frolvlad/alpine-oraclejdk8

MAINTAINER Raymond Wen "rx.wen218@gmail.com"

ENV ANDROID_SDK_VERSION 3859397
ENV GRADLE_VERSION 3.4.1

USER root
RUN apk update && apk add -f zip unzip curl wget openssl make openssh git python

# Install Android SDK
ENV ANDROID_HOME /opt/android-sdk
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
        && mkdir -p ${ANDROID_HOME} \
        && unzip -d ${ANDROID_HOME} sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
        && rm sdk-tools-linux-${ANDROID_SDK_VERSION}.zip
ENV GRADLE_HOME /opt/gradle
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
        && unzip -d /opt/ gradle-${GRADLE_VERSION}-bin.zip \
        && mv /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} \
        && rm gradle-${GRADLE_VERSION}-bin.zip

# Setup environment
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools/bin:${GRADLE_HOME}/bin:
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo

# Install sdk components
RUN yes | sdkmanager --licenses
RUN sdkmanager --list
RUN sdkmanager --update --verbose
RUN sdkmanager \
        "build-tools;23.0.3" \
        "build-tools;25.0.3" \
        "build-tools;26.0.2" \
        "extras;android;m2repository" \
        "ndk-bundle" \
        "platform-tools" \
        "platforms;android-23" \
        "platforms;android-20" \
        "platforms;android-10" \
        "platforms;android-8"
RUN sdkmanager --list
